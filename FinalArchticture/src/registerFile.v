								   

//This function process the instruction
module registerFile(
     input clock,
	input RegWRd, // Enable writinh on busW (0 or 1)
	input RegWRs, // Enable writinh on busW (0 or 1)	
	input reg [3:0] Rd, // equal Rd after finishing all stages (Rd4)
	input reg [3:0] Rs2, // equal Rs2 FROM Instruction module
	input reg [3:0] Rs1, // equal Rs1 FROM Instruction module	  
	input reg [31:0] busWd, 
	input reg [31:0] busWs,
    output reg [31:0] busA,
	output reg [31:0] busB,	
);	

//create array of 16 element each will store a 32 bit instruction
reg	[31:0] registers [0:15];

    always @(posedge clock)
    begin 	
	$readmemh("data1.hex",registers);	
	// get registers
	assign busA = registers[Rs1]; 
	assign busB = registers[Rs2];
	
	// If Write Rd register is enabled
	if (RegWRd == 0'b1 )begin
		registers[Rd] = busWd; 
		$monitor("WD =%h ",busWd );	  
		$monitor("registers[Rd] =%h ",registers[Rd] );
		$monitor("Write in file");
		$writememh("data1.hex",registers);	 	
	end	  
	
	// If Write Rs register is enabled
	if (RegWRs == 0'b1 )begin
		registers[Rs1] = busWs; 	
		$monitor("Write in file");
		$writememh("data1.hex",registers); 	
	end
		
 end	 
	
   
endmodule