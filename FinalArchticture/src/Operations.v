////////////////////////////////////////////////////////////////////////////////
/* 
  This module defines all the operations and assigns their opcode.
  It's more clear to call the operations by their name in the program rather than their opCode
*/
////////////////////////////////////////////////////////////////////////////////

  //-----------R-TYPE INSTRUCTIONS	
  parameter AND = 6'b000000;
  parameter ADD = 6'b000001;
  parameter SUB = 6'b000010;  
  
  //-----------I-TYPE INSTRUCTIONS	
  parameter ANDI = 6'b000011;
  parameter ADDI = 6'b000100;
  parameter LW   = 6'b000101;
  parameter LWPOI = 6'b000110;
  parameter SW  = 6'b000111;
  parameter BGT = 6'b001000;
  parameter BLT = 6'b001001;
  parameter BEQ = 6'b001010;
  parameter BNE = 6'b001011; 
  
  //-----------J-TYPE INSTRUCTIONS	
  parameter JMP  = 6'b001100;
  parameter CALL = 6'b001101;
  parameter RET  = 6'b001110;  
  
  //-----------S-TYPE INSTRUCTIONS	
  parameter PUSH = 6'b001111;
  parameter POP  = 6'b010000;   
  

