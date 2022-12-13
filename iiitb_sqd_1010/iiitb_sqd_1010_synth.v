/* Generated by Yosys 0.12+45 (git sha1 UNKNOWN, gcc 8.3.1 -fPIC -Os) */

module iiitb_sqd_1010(din, reset, clk, y);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  wire _11_;
  wire _12_;
  input clk;
  wire \cst[0] ;
  wire \cst[1] ;
  wire \cst[2] ;
  wire \cst[3] ;
  input din;
  input reset;
  output y;
  sky130_vsdinv _13_ (
    .A(din),
    .Y(_05_)
  );
  sky130_fd_sc_hd__or2_2 _14_ (
    .A(\cst[0] ),
    .B(\cst[3] ),
    .X(_06_)
  );
  sky130_fd_sc_hd__or3_2 _15_ (
    .A(\cst[1] ),
    .B(reset),
    .C(din),
    .X(_07_)
  );
  sky130_fd_sc_hd__o32a_2 _16_ (
    .A1(reset),
    .A2(_05_),
    .A3(\cst[2] ),
    .B1(_06_),
    .B2(_07_),
    .X(_04_)
  );
  sky130_fd_sc_hd__and2_2 _17_ (
    .A(\cst[3] ),
    .B(_05_),
    .X(_08_)
  );
  sky130_fd_sc_hd__buf_1 _18_ (
    .A(_08_),
    .X(_00_)
  );
  sky130_vsdinv _19_ (
    .A(reset),
    .Y(_09_)
  );
  sky130_fd_sc_hd__and3_2 _20_ (
    .A(_09_),
    .B(_05_),
    .C(\cst[2] ),
    .X(_10_)
  );
  sky130_fd_sc_hd__buf_1 _21_ (
    .A(_10_),
    .X(_01_)
  );
  sky130_fd_sc_hd__and3_2 _22_ (
    .A(\cst[1] ),
    .B(_09_),
    .C(din),
    .X(_11_)
  );
  sky130_fd_sc_hd__buf_1 _23_ (
    .A(_11_),
    .X(_03_)
  );
  sky130_fd_sc_hd__and3_2 _24_ (
    .A(_09_),
    .B(din),
    .C(_06_),
    .X(_12_)
  );
  sky130_fd_sc_hd__buf_1 _25_ (
    .A(_12_),
    .X(_02_)
  );
  sky130_fd_sc_hd__dfxtp_2 _26_ (
    .CLK(clk),
    .D(_04_),
    .Q(\cst[0] )
  );
  sky130_fd_sc_hd__dfxtp_2 _27_ (
    .CLK(clk),
    .D(_01_),
    .Q(\cst[1] )
  );
  sky130_fd_sc_hd__dfxtp_2 _28_ (
    .CLK(clk),
    .D(_02_),
    .Q(\cst[2] )
  );
  sky130_fd_sc_hd__dfxtp_2 _29_ (
    .CLK(clk),
    .D(_03_),
    .Q(\cst[3] )
  );
  sky130_fd_sc_hd__dfxtp_2 _30_ (
    .CLK(clk),
    .D(_00_),
    .Q(y)
  );
endmodule