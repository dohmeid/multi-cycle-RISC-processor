 								   
//This module adds extension to immediate based on extOp signal
module Ext(	
	input extOp, // Need to be fetched from main & alu control module (0 or 1)	 
	input reg [15:0] Imm_bef, // imm before adding extension (16 bit)
    output reg [31:0] Imm_ext,// imm after adding extension	(32 bit)
		
);	


//reg [15:0] ext;	// to store extension part
//reg last_bit = Imm_bef[15] ; // get last bit of imm to get sign bit.

    always @(extOp or Imm_bef )
    begin 	
	// if extop = 1 , extension is sign bit of imm
	if (extOp == 1'b1 )begin 
		//ext = {16{last_bit}}; // Concatenate sign bit 16 times 
		Imm_ext = {{16{Imm_bef[15]}},Imm_bef};
	 	
	end	
	// if extop = 0 , extension is 16 bits of zeros
	else begin
		//ext = {16{1'b0}}; 
		//Imm_ext = {ext,Imm_bef};
	end
	 
		
 end	 
	
   
endmodule  


