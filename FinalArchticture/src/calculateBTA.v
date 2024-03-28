
//This module calculates the branch target address to be assigned in PC
module BTA(	
    input reg [31:0] pc_next, 
    input reg [31:0] Imm_ext,  
    output reg [31:0] bta,
		
);	


    always @(pc_next or Imm_ext)
    begin 	
		
	assign bta = pc_next + Imm_ext;
		
 end	 
	
   
endmodule  


