
//This function process the instruction
module PI(
    input [31:0] Instruction_Code,
	output reg [5:0] opcode,
	output reg [3:0] Rd,
	output reg [3:0] Rs2,
	output reg [3:0] Rs1,
	output reg [15:0] Imm,	
	output reg [1:0] mode,	
	output reg [25:0] offset,
);	

    always @(Instruction_Code)
    begin  
		
		opcode = Instruction_Code[31:26];
  		if (opcode <= 6'b10)begin
			// This is R-type instruction  
			Rd = Instruction_Code[25:22];
			Rs1 = Instruction_Code[21:18];
			Rs2 = Instruction_Code[17:14] ;
		end
		else if (opcode > 6'b10 && opcode <= 6'b1011) begin 
			// This is I-type instruction 
			Rd = Instruction_Code[25:22];
			Rs1 = Instruction_Code[21:18];
			Imm = Instruction_Code[17:2];	
			mode = Instruction_Code[1:0];
			$monitor("imm : %h",Imm);
			
		end
	    else if (opcode > 6'b1011 && opcode <= 6'b1110)begin	
			// This is J-type instruction  
		  	offset = Instruction_Code[25:0];	
		end 
			// This is S-type instruction 
	    else begin
		  Rd = Instruction_Code[25:22];
	
        end
    end	   
   
endmodule