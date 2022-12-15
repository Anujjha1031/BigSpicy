# BigSpicy 
Bigspicy is a tool for merging circuit descriptions (netlists), generating Spice decks modeling those circuits, generating Spice tests to measure those models, and analyzing the results of running Spice on those tests.

Bigspicy allows you to combine structural Verilog from a PDK, Spice models of standard cells, a structural Verilog model of some circuit implemented in that PDK, and parasitics extracted into SPEF format. You can then reason about the electrical structure of the design however you want.

Bigspicy generates Spice decks in Xyce format, though this can (and should) be extended to other Spice dialects.

This repo shows the steps for merging the SPEF, verilog and spice netlist into a circuit protobuf and generating the spice file of the design which can further be used to perform various tests and analysis.In this repo, I have used the design of sequence detector implemented using SKY130 PDKS. The RTL to GDS2 flow of the given design can be referred from the following github repo.
https://github.com/Anujjha1031/iiitb_sqd_1010

# Flowchart
![206892403-9238ee48-5b2f-43e7-86d4-9f81d6f67f62](https://user-images.githubusercontent.com/110462872/207245440-fed833ad-ef2f-47e1-8743-348cc5778217.png)

# Prerequisites/Tools
To install the python dependencies, follow the below steps:

```
git clone https://github.com/Anujjha1031/BigSpicy
cd BigSpicy/
sudo apt-get update
pip install -e ".[dev]"
pip install -r requirements.txt
sudo apt install -y protobuf-compiler iverilog
```

Another prerequisite for this step is to compile protobufs into python file.(_pb2.py).
To compile the protobufs, type the below command in terminal in the BigSpicy(cloned_repo) directory:

```
git submodule update --init  
protoc --proto_path vlsir vlsir/*.proto vlsir/*/*.proto --python_out=.
protoc proto/*.proto --python_out=.
```

We also need tools like Xyce and XDM installed.
To install the mentioned tools use the following links:

XDM: Primitives and spice files are needed by BigSpicy but they are not processed in their raw format. The files that are fed to BigSpicy should be in Xyce format as minimal internal processing is required for them.

XDM can be installed from the below link
https://github.com/Xyce/XDM

XYCE: After obtaining all the required files, SKY130 Primitives and Spice files in Xyce format, netlist and spice files. We need to merge them as in order to generate a spice deck the order of ports for each instantiated module are also required which leads to dependency on PDK. We then convert the merged files into protobuf with the help of protoc.

Xyce can be installed from the below link
https://xyce.sandia.gov/documentation/BuildingGuide.html


# Converting the PDKs:
First step is to convert the PDKs into Xyce format.
To convert the PDK's go to the directory where XDM is installed and type the following command:

```
xdm_bdl -s hspice "path to the pdk"/"file to be converted" -d lib
```

# Merging
We merge the files into circuit protobuf(final.pb) which is used to generate the whole module spice models and to conduct the various tests using Xyce.
To merge the files, follow the below steps in the BigSpicy directory:

```
./bigspicy.py \
   --import \
   --spef example_inputs/iiitb_sqd_1010/iiitb_sqd_1010.spef \
   --spice lib/sky130_fd_sc_hd.spice \
   --verilog example_inputs/iiitb_sqd_1010/iiitb_sqd_1010.v \
   --spice_header lib/sky130_fd_pr__pfet_01v8.pm3.spice \
   --spice_header lib/sky130_fd_pr__nfet_01v8.pm3.spice \
   --spice_header lib/sky130_ef_sc_hd__decap_12.spice \
   --spice_header lib/sky130_fd_pr__pfet_01v8_hvt.pm3.spice \
   --top iiitb_sqd_1010 \
   --save final.pb \
```

This will generate final.pb file.
To specify the location of the final.pb file, go to bigspicy.py file and search for "def withoptions()" function. Change the "output_dir" variable to your desired path.

# Generating whole-module spice file
The protobuf file that we have generated in the previous step and PDK spice file are then used to make a whole module spice model. We then pass the --flatten_spice argument to convert the whole module spice model into transistor level spice.
After generating the "final.pb" file, we now generate the spice file("spice.sp" in this case) for our design which can be further used to run tests.
This step takes the pdks, and the design as input and gives the spice file as output.
To generate the spice file, follow the below steps in BigSpicy directory:

```
./bigspicy.py --import \
    --verilog example_inputs/iiitb_sqd_1010/iiitb_sqd_1010.v \
    --spice lib/sky130_fd_sc_hd.spice \
    --spice_header lib/sky130_fd_pr__pfet_01v8.pm3.spice \
    --spice_header lib/sky130_fd_pr__nfet_01v8.pm3.spice \
    --spice_header lib/sky130_ef_sc_hd__decap_12.spice \
    --spice_header lib/sky130_fd_pr__pfet_01v8_hvt.pm3.spice \
    --save final.pb \
    --top iiitb_sqd_1010 \
    --flatten_spice --dump_spice spice.sp
```

The above steps will generate "spice.sp" file in the mentioned directory.

# Running Xyce to perform tests

# Generating test to measure input capacitance
We take the protobuf file, PDK primitives file and the spice file of our module to generate the test manifest and circuit analysis protobuf files. We then run Xyce to perform tests.

# Measuring Input Capacitance in BigSpicy
Input Files to these steps
"Final.pb", Spice file for our design
Output File
All necessary test files, "test_manifest.pb", "circuit_analysis.pb"

# Linear and transient analysis
We then perform the linear and transient analysis using Xyce with the help of test manifest and circuit analysis protobuf files.

# Generating wire and whole module tests
We take the protobuf file, primitives, spice, test manifest and circuit analysis file to generate test for whole module.

# Perform analysis on wire and whole module tests
We take Final.pb, PDK primitives, test_manifest, test_analysis, PDK spice decks. Input capacitance and delays will be analysed.

# Future Works
Presently we are working on performing tests on the generated spice file "spice.sp".
We are trying to find the path delay for few paths using Xyce and compare the same with other available tools.
We expect this to be a lot faster method for timing analysis than the other tools available now.

# Acknowlwdgements
* Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
* Madhav Rao, Professor, IIIT-Bangalore
* Nanditha Rao, Professor, IIIT-Bangalore
