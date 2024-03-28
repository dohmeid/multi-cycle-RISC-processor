////////////////////////////////////////////////////////////////////////////////
/* 

*/
////////////////////////////////////////////////////////////////////////////////
module Incrementer(in,out);
	input [31:0]in;    
	output reg [31:0]out;   
	
	always @ (in)	
	begin 
		out = in + 1; //cause it's byte addressable 32bits=4bytes
	end
	
endmodule		 

////////////////////////////////////////////////////////////////////////////////
module decrementer(in,out);	  //used in pop stack, to decrease the top value
	input [31:0]in;    
	output reg [31:0]out;   
	
	always @ (in)	
	begin 
		out = in - 1; //cause it's byte addressable 32bits=4bytes
	end
	
endmodule	