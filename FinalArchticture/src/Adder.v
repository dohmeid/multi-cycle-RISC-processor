////////////////////////////////////////////////////////////////////////////////
/* 
Includes all the needed versions of mux:
mux2x1 for 32bits
mux4x1 for 32bits

*/
////////////////////////////////////////////////////////////////////////////////
module Adder(x,y,address);
	input [31:0]x,y;   
	output reg [31:0] address;
	
	always @ (x or y)	
	begin 
		address = x+y;
	end
	
endmodule	