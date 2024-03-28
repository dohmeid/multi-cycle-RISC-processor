// PC Control unit to get pcsrc signal 
module PCControl(
	input reg [5:0] opcode,
	input carry,
	input zero,
    output reg[1:0] pcsrc,
);	



always @(*)
    begin 	
		
	 // If BGT taken
	  if (opcode == 8 && carry == 1 && zero == 0) begin 
		 pcsrc <= 2;				
	  end
	  // If BLT taken
	  else if (opcode == 9 && carry == 0 && zero == 0) begin 
		 pcsrc <= 2;				
	  end 
	  // If BEQ taken
	  else if (opcode == 10 && zero == 1) begin 
		 pcsrc <= 2;				
	  end 	
	  // If BNE taken
	  else if (opcode == 11 && zero == 0) begin 
		 pcsrc <= 2;				
	  end 
	  // If Jump
      else if (opcode > 11 && opcode < 14 )begin	
		pcsrc <= 1;	
	  end 
	  // If RET	 001110
      else if (opcode == 14)begin	
		pcsrc <= 3;	
	  end 
	  // If normal instruction or branch not taken
	 else begin
	   pcsrc = 0;
	 end
			
	end
	
endmodule




   	  

