////////////////////////////////////////////////////////////////////////////////
/* 
Includes all the needed versions of mux:
mux2x1 for 32bits
mux4x1 for 32bits

*/
////////////////////////////////////////////////////////////////////////////////
module mux2x1(x,y,s,z);
	input [31:0]x,y;   
	input s;
	output reg [31:0]z;
	
	always @ (x or y or s)	
	begin 
		if(s==0)
			z = x;
		else
			z = y; 
	end
	
endmodule	


module mux4x1(a1,a2,a3,a4,s,z);
	input [31:0]a1,a2,a3,a4;   
	input [1:0]s;
	output reg [31:0] z;
	
	always @ (a1 or a2 or a3 or a4 or s)	
	begin 
		case(s)
	      2'b00: 
		  	z = a1;
	      2'b01: 
		  	z = a2;
	      2'b10: 
		  	z = a3;
	      2'b11: 
		  	z = a4;
	      default: 
		  	z = a1; 
	    endcase
	end
	
endmodule