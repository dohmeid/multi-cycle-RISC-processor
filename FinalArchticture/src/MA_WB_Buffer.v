module MA_WB_Buffer(clk,ALU_RESULT, MEMORY_RESULT, pALU_RESULT, pMEMORY_RESULT); 
	
	
	input clk;	 
	input [31:0] ALU_RESULT, MEMORY_RESULT;
	output reg [31:0] pALU_RESULT, pMEMORY_RESULT;
	
	 
	//at each clock cycle:													  
	always @(posedge clk)
	begin
		pALU_RESULT = ALU_RESULT;  
		pMEMORY_RESULT = MEMORY_RESULT;
	end	
	
endmodule	