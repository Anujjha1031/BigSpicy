module iiitb_sqd_1010(din, reset, clk, y);
input din;
input clk;
input reset;
output reg y;
reg [1:0] cst, nst;
parameter S0 = 2'b00, //all state
          S1 = 2'b01,
          S2 = 2'b10,
          S3 = 2'b11;
always@(posedge clk)
	begin
	if(reset) begin
		y<=1'b0;
		cst<=1'b0;
		end
	else cst<=nst;
	
	if(din == 0 && cst == S3) y<= 1'b1;
	else	y<=1'b0;
	end
always @(cst or din)
 begin
 case (cst)
   S0: if (din == 1'b1)
          nst <= S1;
      else
          nst <= S0;
   S1: if (din == 1'b0)
        nst <= S2;
       else
           nst <= S0;
   S2: if (din == 1'b1)
         nst <= S3;
       else
          nst <= S0;
   S3: if (din == 1'b0)
          nst <= S0;
       else
          nst <= S1;
   default: nst <= S0;
  endcase
end

always@(posedge clk )
          begin
           if (reset)
             cst <= S0;
           else 
             cst <= nst;
          end
endmodule
