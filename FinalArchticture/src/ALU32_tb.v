module ALU32_tb;

  // Parameters
  parameter TIME_SCALE = 1ns;

  // Inputs
  reg [31:0] X, Y;
  reg [1:0] AluOp;

  // Outputs
  wire [31:0] Z;
  wire ZeroFlag, CarryFlag;

  // Instantiate the ALU32 module
  ALU32 ALU32_test (
    .X(X),
    .Y(Y),
    .AluOp(AluOp),
    .Z(Z),
    .ZeroFlag(ZeroFlag),
    .CarryFlag(CarryFlag)
  );

  //Clock generation
  reg clk;
  initial begin
    clk = 0;
    forever #((TIME_SCALE / 2)) clk = ~clk;
  end

  //Test stimulus
  initial begin
    // Test case 1: AND operation
    X = 32'hAAAA_5555;
    Y = 32'hFFFF_0000;
    AluOp = 2'b00; 
    #10; // Allow some time for the calculation
   
    // Test case 2: ADD operation
    X = 32'hAAAA_5555;
    Y = 32'h1122_0000;
    AluOp = 2'b01; 
    #10; 
	
	//Test case 3: SUB operation
    X = 32'hAAAA_FFFF;
    Y = 32'h2222_3344;
    AluOp = 2'b10; 
    #10; 
	
	//zeroflag=1 case
    X = 32'hAAAA_FFFF;
    Y = 32'hAAAA_FFFF;
    AluOp = 2'b10; 
    #10; 
	
    //carry flag=1 case, cuz X is greater than Y
    X = 32'hAAAA_FFFF;
    Y = 32'h4512_ACD2;
    AluOp = 2'b10; 
    #10; 

    $finish; // Stop simulation
  end

endmodule