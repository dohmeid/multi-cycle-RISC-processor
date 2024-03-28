module EX_MA_Buffer(clk, ALU_RESULT, ZERO_FLAG, CARRY_FLAG, NEW_RS1, RD,
				pALU_RESULT, pZERO_FLAG, pCARRY_FLAG, pNEW_RS1, pRD); 
	
	
	input clk;	 
	input [31:0] ALU_RESULT, NEW_RS1, RD;
	input ZERO_FLAG, CARRY_FLAG; 
	
	output reg [31:0] pALU_RESULT, pNEW_RS1, pRD;
	output reg pZERO_FLAG, pCARRY_FLAG; 
	 
	
	
	
	//at each clock cycle:													  
	always @(posedge clk)
	begin
		pALU_RESULT = ALU_RESULT;  
		pNEW_RS1 = NEW_RS1;
		pRD = RD;		
		pZERO_FLAG = ZERO_FLAG;
		pCARRY_FLAG = CARRY_FLAG;
	end	
	
endmodule	