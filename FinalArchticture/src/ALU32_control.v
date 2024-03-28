////////////////////////////////////////////////////////////////////////////////
/* 
This is the ALU Control Unit
  AND -> 00	        0
  ADD -> 01	        1
  SUB -> 10		   2
  no operation -> 11  3 zero

  OpCode   type   ALU Selection							 
  000000   AND		00
  000001   ADD         01
  000010	  SUB	    10 
  
  000011   ANDI	    00
  000100   ADDI       01 
  
  000101   LW         01
  000110   LW.POI	    01
  000111   SW         01
  
  001000 	  BGT 	  10
  001001   BLT 	  10
  001010   BEQ 	  10
  001011   BNE 	  10
  
*/
////////////////////////////////////////////////////////////////////////////////   
`include "Operations.v"
module ALU32_control (OpCode,AluOp);

	input [5:0] OpCode;  //6bits input/opcode
	output reg [1:0] AluOp ; //2bits selector for 4 different operations
												 
	always @(OpCode)
	begin
		case(OpCode)
		//ALU logical and arithmatic operations	
	     AND: 
	     	AluOp = 2'b00;  
	     ADD:
	         AluOp = 2'b01;
	     SUB:  
		 	AluOp = 2'b10;
	     ANDI:
		 	AluOp = 2'b00;
	     ADDI:
		 	AluOp = 2'b01;
		 
		 //load and store instructions use the ADD operation to calculate the memory address
		 LW: 
		 	AluOp = 2'b01;			 
		 LWPOI: 
		 	AluOp = 2'b01;		 
		 SW: 
		 	AluOp = 2'b01;
		 
		 //branch instructions use the SUB operation to compare the operands 	 
		 BGT: 
		 	AluOp = 2'b10;		 
		 BLT:
		 	AluOp = 2'b10;		 
		 BEQ: 
		 	AluOp = 2'b10;		 
		 BNE: 
		 	AluOp = 2'b10;
		 
		 //other 	instructions don't need the ALU like: JMP,CALL,RET,POP,PUSH 
	     default:   
		 	AluOp = 2'b11;
		 
		endcase		
	end	
	
endmodule