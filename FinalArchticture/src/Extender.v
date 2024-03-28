////////////////////////////////////////////////////////////////////////////////
/* 
This unit extendes the immediate(16 bit) to 32bit	

the extension is unsigned for logic instructions -> ExtOp = 0
the extension is signed otherwise  -> ExtOp = 1

*/
////////////////////////////////////////////////////////////////////////////////
module Extender(in,ExtOp, out);
    input [16:0] in;
    input  ExtOp;
    output reg [31:0] out;
	
	
	
	//assigns 16 additional bits which equal zeros(unsigned) or the most high bit (sign bit) for the input(signed) 
	always @(in or ExtOp)
	begin
		if(ExtOp == 1'b1)		   
			out <= {{16{in[15]}},in}; //signed extention 
	   	else	  
			   out <= { {16{1'b0}}, in };   //unsigned extention
    		     
     end 
	 
endmodule
