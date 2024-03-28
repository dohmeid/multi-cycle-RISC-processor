////////////////////////////////////////////////////////////////////////////////
/* 
 This is the Main Control Unit
 It calculates the control signals for all instruction types 
*/
////////////////////////////////////////////////////////////////////////////////  
`include "Operations.v"
module MainControlUnit (OpCode,ALUSrc,RdWB,ExtOp,MemWr,MemRd,MemIn,MemAddress,STop,RegWRd,RegWRs); 
	
	input [5:0] OpCode;  //6bits input/opcode
	output reg [1:0] ALUSrc,STop ;
	output reg ExtOp,RdWB,MemWr,MemRd,MemIn,MemAddress,RegWRd,RegWRs ;
												 
	always @(OpCode)
	begin
		case(OpCode)	   
			
		//ALU logical and arithmatic operations  (R-type): 
		//ALUSrc=00	(take Rs2 as second source)
		//RdWB=0 (take ALU result directly)
		//ExtOp=x (don't care, R-type does not have immediate)
		//MemWr=0.MemRd=0, don't use the data memory   
		//MemIn=x don't use memory input
		//MemAddress=x, don't use memory
	     AND: begin 
	     	 ALUSrc = 2'b00;
			 RdWB = 1'b0;
			 ExtOp = 1'bx;
			 MemWr = 1'b0;  
 		  	 MemRd = 1'b0;
			 MemIn = 1'bx;
			 MemAddress = 1'bx;
			 RegWRd = 1'b1;
			 RegWRs = 1'b0;
			 end
	     ADD: begin 
			 ALUSrc = 2'b00;
	     	 RdWB = 1'b0;
			 ExtOp = 1'bx;
			 MemWr = 1'b0;  
 		  	 MemRd = 1'b0;
			 MemIn = 1'bx;
			 MemAddress = 1'bx;
			 RegWRd = 1'b1;
			 RegWRs = 1'b0;
			 end
	     SUB: begin 
			 ALUSrc = 2'b00;
	     	RdWB = 1'b0;
			 ExtOp = 1'bx;
			 MemWr = 1'b0;  
 		  	 MemRd = 1'b0;
			 MemIn = 1'bx;
			 MemAddress = 1'bx;
			 RegWRd = 1'b1;
			 RegWRs = 1'b0;
		     end 
		 
		//ALU logical and arithmatic operations  (I-type): 
		//ALUSrc=01	(take extended immediate as second source)
		//RdWB=00 (take ALU result directly)
		//ExtOp=0 for logic instruction(ANDI), ExtOp=1 for arithmatic instruction(ADDI) 
	    //MemWr=0.MemRd=0, don't use the data memory 
		//MemIn=x don't use memory input
		//MemAddress=x, don't use memory
		ANDI:begin 
			 ALUSrc = 2'b01;
	     	 RdWB = 1'b0;
			 ExtOp = 1'b0;
			 MemWr = 1'b0;  
 		  	 MemRd = 1'b0;
			 MemIn = 1'bx;
			 MemAddress = 1'bx;
			 RegWRd = 1'b1;
			 RegWRs = 1'b0;
			 end
	     ADDI:begin 
			 ALUSrc = 2'b01;
	     	 RdWB = 1'b0;
			 ExtOp = 1'b1; 
			 MemWr = 1'b0;  
 		  	 MemRd = 1'b0;
			 MemIn = 1'bx;
			 MemAddress = 1'bx;
			 RegWRd = 1'b1;
			 RegWRs = 1'b0;
			 end
			 	 
	    //load and store instructions (I-type): 
		//ALUSrc=01	(take extended immediate as second source)
		//RdWB=1 (take memory output directly for load), don't care for store (doesn't write anything) 
		//ExtOp=1 - signed immediate for address calculations 
		//MemIn=x dont use memory input
		//MemAddress=0, use ALU result as memory address
		 LW: begin 
	    	   	 ALUSrc = 2'b01;
	     	RdWB = 1'b1;
			 ExtOp = 1'b1;
			 MemWr = 1'b0;  //load only reads memory
 		  	 MemRd = 1'b1; 
			 MemIn = 1'bx;
			 MemAddress = 1'b0;
			 RegWRd = 1'b1;
			 RegWRs = 1'b0;
		     end			 
	   LWPOI: begin 
	     	 ALUSrc = 2'b01;
	     	RdWB = 1'b1;
			 ExtOp = 1'b1;
			 MemWr = 1'b0;  //load only reads memory
 		  	 MemRd = 1'b1;
			 MemIn = 1'bx;
			 MemAddress = 1'b0;
			 RegWRd = 1'b1;
			 RegWRs = 1'b1;
	   		end	
	   //MemIn=0 use Rd as memory input
		 SW: begin 
	     	 ALUSrc = 2'b01;
	     	 RdWB = 1'bx;
			 ExtOp = 1'b1;
			 MemWr = 1'b1;  //store only writes on memory
 		  	 MemRd = 1'b0;
			 MemIn = 1'b0;
			 MemAddress = 1'b0;
			 RegWRd = 1'b0;
			 RegWRs = 1'b0;
			 end
			 
			 
		 //branch instructions (I-type):   
		 //ALUSrc=10	(take Rd as second source)	   
	      //RdWB= don't care write on Rd 
		 //ExtOp=1 - signed immediate for address calculations 
		 //MemWr=0.MemRd=0, don't use the data memory 
		 //MemIn=x don't use memory input
		//MemAddress=x, don't use memory
		 BGT: begin 
			 ALUSrc = 2'b10;
			RdWB = 1'bx;
			 ExtOp = 1'b1;
			 MemWr = 1'b0;  
 		  	 MemRd = 1'b0;
			MemIn = 1'bx;
			MemAddress = 1'bx;
			 RegWRd = 1'b0;
			 RegWRs = 1'b0;
			 end	 
		 BLT: begin 
			 ALUSrc = 2'b10;
			RdWB = 1'bx;
			 ExtOp = 1'b1;
			 MemWr = 1'b0;  
 		  	 MemRd = 1'b0;
			MemIn = 1'bx;
			MemAddress = 1'bx;	
			 RegWRd = 1'b0;
			 RegWRs = 1'b0;
			 end	 
		 BEQ: begin 
			 ALUSrc = 2'b10;
			 RdWB = 1'bx;
			 ExtOp = 1'b1;
			  MemWr = 1'b0;  
 		  	 MemRd = 1'b0;
			MemIn = 1'bx;
			MemAddress = 1'bx;
			 RegWRd = 1'b0;
			 RegWRs = 1'b0;
			 end		 
		 BNE: begin 
	     	 ALUSrc = 2'b10;
			RdWB = 1'bx;
			 ExtOp = 1'b1;
			 MemWr = 1'b0;  
 		  	 MemRd = 1'b0;
			MemIn = 1'bx;
			MemAddress = 1'bx;
			 RegWRd = 1'b0;
			 RegWRs = 1'b0;
		      end   
		 	 
			  
		 //J-Type instructions
		  //ALUSrc=xx	- don't use ALU for JMP   
	      //RdWB=xx don't care write on Rd 
		 //ExtOp=1 - signed immediate for address calculations 
		 //MemWr=0.MemRd=0, don't use the data memory
		 //MemIn=x don't use memory input
		//MemAddress=x, don't use memory
		 JMP: begin 
			 ALUSrc = 2'bxx;
			RdWB = 1'bx;
			 ExtOp = 1'b1;
			 MemWr = 1'b0;  
 		  	 MemRd = 1'b0;
			MemIn = 1'bx;
			MemAddress = 1'bx;
			 RegWRd = 1'b0;
			 RegWRs = 1'b0;
			 end	 
		 CALL: begin 
	     	 ALUSrc = 2'bxx;
			 RdWB = 1'bx;
			 ExtOp = 1'bx;
			 MemWr = 1'b1;  
 		  	 MemRd = 1'b0;
		      MemIn = 1'b1;
			 MemAddress = 1'b1;
			 STop=2'b00;  
			  RegWRd = 1'b0;
			 RegWRs = 1'b0;
			 end	 
		 RET: begin 
	     	 ALUSrc = 2'bxx;
			RdWB = 1'bx;
			 ExtOp = 1'b1;
			 MemWr = 1'b0;  
 		  	 MemRd = 1'b1;
		     MemIn = 1'bx;
			 MemAddress = 1'b1;
			 STop=2'b10; 
			  RegWRd = 1'b0;
			 RegWRs = 1'b0;
			 end		 
		 
		 //S-TYPE instructions 
		 //ALUSrc=xx	- don't use ALU    
	      //RdWB=xx don't care write on Rd for PUSH
		 //ExtOp=x - don't have immediate 
		 //MemWr=1,MemRd=0, write on stack segment from data memory
		 //MemIn=0 memory input = Rd
		//MemAddress=1, use stack memory address memory	
		//STop=1'b0 increment stack
		 PUSH: begin 
	          ALUSrc = 2'bxx;
			RdWB = 1'bx;
			 ExtOp = 1'bx;
			 MemWr = 1'b1;  
 		  	 MemRd = 1'b0;
			 MemIn = 1'b0;
			 MemAddress = 1'b1;
			 STop=2'b00; 
			  RegWRd = 1'b0;
			 RegWRs = 1'b0;
			 end	  
		 //RdWB=01 Rd=memory result 
		 //MemWr=1,MemRd=0, read form stack segment from data memory
		 //STop=1'b0 decrement stack
		 POP: begin 
	     	 ALUSrc = 2'bxx;
			RdWB = 1'b1;
			 ExtOp = 1'bx;
			 MemWr = 1'b0;  
 		  	 MemRd = 1'b1;
			 MemIn = 1'bx;
			 MemAddress = 1'b1;
			 STop=2'b01;
			 RegWRd = 1'b1;
			 RegWRs = 1'b0;
			 end	 
		
		 
		 //other 	instructions don't need the ALU like: JMP,CALL,RET,POP,PUSH 
	     default:  begin 
	     	 ALUSrc = 2'bxx;
			 RdWB = 2'b01;
			 ExtOp = 1'bx;
			 MemWr = 1'b0;  
 		  	 MemRd = 1'b1;
			 MemIn = 1'bx;
			 MemAddress = 1'b1;
			 STop=2'b01;
			 end	 
		 
		 	
		 
		endcase		
	end	
	
endmodule																		  													   