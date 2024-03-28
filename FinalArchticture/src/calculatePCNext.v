// This module calculates the next pc based on pcsrc signal  
module calculatePCNext(
	input reg [1:0] PCSrc,
	input reg [31:0] pc_cur, 
    input reg [31:0] bta,  
	input reg [25:0] offset,
	input reg [31:0] top_address,
    output reg[31:0] pc_next,
);	

    always @(*)
    begin
		// If pcsrc = 0, normal instruction or branch not taken
		if (PCSrc == 2'b00 )begin 
			assign pc_next = pc_cur+1; 
		 	
		end	
		// If pcsrc = 1, jump instruction
		else if(PCSrc == 2'b01 )begin 
			assign pc_next = {pc_cur[31:26],offset}; 
		 	
		end	 
		// If pcsrc = 2,  branch taken
		else if(PCSrc == 2'b10 ) begin
			assign pc_next = bta;
		end	 
		// If pcsrc = 3,  RET
		else if(PCSrc == 2'b11 ) begin
			assign pc_next = top_address;
		end	

    end	   

endmodule	  

