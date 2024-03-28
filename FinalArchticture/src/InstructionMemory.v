
/***********************************************************************************************************
Instruction memory takes 32-bit Program counter input to give the corresponding 32-bit Instruction code output
*************************************************************************************************************/ 

module INST_MEM(
    input [31:0] PC,
    output reg [31:0] instruction,
);	

//create array of 256 element each will store a 32 bit instruction
reg	[31:0] instruction_memory [0:255];						

//The readmh function reads the hexadecimal numbers from the file program.mips and maps them into instruction_memory
    
	initial
	begin
		$readmemh("program.hex",instruction_memory); 
		assign instruction = instruction_memory[PC];
		$monitor("instruction inside instmem: %h",	instruction); 
		$monitor("PC inside instmem: %h",	PC);
			
    end	   


endmodule