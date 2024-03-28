////////////////////////////////////////////////////////////////////////////////
/* 
ALU Arithmetic and Logic Operations	

This unit outputs are:	
	X,Y   - the opearnds
	AluOp - selects the alu operation such that:	
    AluOp    ALU Operation							 
     00       Z = X & Y;	   AND  
     01       Z = X + Y;	   ADD
     10	     Z = X - Y;	   SUB
	11		Z=0 		        nothing - no operation needed
   
This unit outputs are:
	Z = ALU result
	ZeroFlag   if X==Y then ZeroFlag=1 otherwise ZeroFlag=0
	CarryFlag  if X>Y then CarryFlag=1 otherwise CarryFlag=0

*/
////////////////////////////////////////////////////////////////////////////////
module ALU32 (X,Y,AluOp, Z,ZeroFlag,CarryFlag);
	
	input [31:0] X,Y;    //32bit inputs
	input [1:0] AluOp ;  //2bits selector for 3 different operations
	output reg [31:0] Z; //32bit output
	output reg ZeroFlag; //1bit flags 
	output reg CarryFlag; //1bit flags
	
	initial begin 	 
        ZeroFlag <= 0;
        CarryFlag <= 0; 
  	end 		  
	  
	//calculate the alu result
	always @(*)
	begin	   
		case(AluOp)
	     2'b00: //AND 
	     	Z = X & Y;  
	     2'b01: //ADD
	         Z = X + Y;
	     2'b10: //SUB 
		 	Z = X - Y;
		 2'b11:  
	         Z = 32'd0;
	     default: 
		    Z = 32'd0; 
		endcase	
		$monitor("x=%h y=%h op=%h z=%h  zero=%h carry=%h ",X,Y,AluOp,Z,ZeroFlag,CarryFlag);	   
		
		//set the flags based on the alu result
		//check zero flag -- for BEQ,BNE instructions
		if (Z == 32'd0) 
			ZeroFlag = 1;	    
		else 
			ZeroFlag = 0;	 
			
		//check the MSB to determine output sign --- for BGT,BLT instructions  
		if (Z[31] == 1'b0) //if the last bit is 0 then the output is +ve
			CarryFlag = 0;		    
		else 		  //otherwise, if the last bit is 1 then the output is -ve
			CarryFlag = 1;
	end					  
	
	
	/* note:
	-for BEQ instruction:  ZeroFlag = 1
	-for BNE instruction:  ZeroFlag = 0
	-for BGT instruction:  ZeroFlag = 0 && CarryFlag = 1
	-for BLT instruction:  ZeroFlag = 0 && CarryFlag = 0	
	*/
	
endmodule