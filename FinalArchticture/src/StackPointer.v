////////////////////////////////////////////////////////////////////////////////
/* 
This represents the stack pointer speacial register (SP)
It stores the top of the stack segment from the Data Memory  
*/
////////////////////////////////////////////////////////////////////////////////
module StackPointer(new_top,clk, top); 
	
	input [31:0] new_top;
	input clk;
	output reg [31:0] top; 
	
	//initially the top of the stack = 32'd256 ,it's the beginning of the stack segment from the data memory
	initial begin
		top = 32'd256;
	end								  
	
	//at each clock cycle:
	//either increment the top (in case of push),  or the top stays the same (in case of pop) 
	always @(posedge clk)
	begin
		top = new_top; 
	end	
	
endmodule	