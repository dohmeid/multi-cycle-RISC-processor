 /***********************************************************************************************************
Instruction fetch unit has clock input and 32-bit instruction code output.It consists of Instruction Memory,
Program Counter(PC) and an adder to increment counter by 4 on every positive clock edge.
*************************************************************************************************************/
`include "InstructionMemory.v"

module IF(
   
	input reg [31:0] PC_cur, 
    output [31:0] Instruction_Code
);	

// Declare 32-bit PC and initialize it to zero
//reg [31:0] PC1  ; 

// Initialize instruction memory block
reg	[31:0] instruction_memory [0:255];						

//The readmh function reads the hexadecimal numbers from the file program.mips and maps them into instruction_memory
    
	initial
	begin
		$readmemh("program.hex",instruction_memory); 
		
	end	

endmodule