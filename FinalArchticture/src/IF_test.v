
module test;
// registers for instruction fetch
reg [31:0] instructionf;
reg clk;  
  


// registers for instruction processing
reg [5:0] opcode;
reg [3:0] Rd;
reg [3:0] Rt;
reg [3:0] Rs;
reg [15:0] Imm;	
reg [1:0] mode;
reg [25:0] offset; 


reg RegWR; // Enable writinh on busW (0 or 1)	 
reg [31:0] busW;
reg [31:0] busA;
reg [31:0] busB;	



// register for extension immediate
reg [31:0] Imm_ext;
reg extOp;
	

reg [3:0] Rd_next;
reg RegDst;


// NPC registers
  
reg [1:0] PCSrc = 2'b10; 
reg [31:0] bta;
reg [31:0] PC_c = 0;  
reg [31:0] PC_n; 


always
begin
    #10 clk = ~clk;
end


INST_MEM ins_mem(PC_c,instructionf);
PI ins(clk,instructionf,opcode,	Rd,Rt,Rs,Imm,mode,offset);		
registerFile rf(clk,RegWR,Rd,Rt,Rs,busW,busA,busB);
Ext ex(clk,extOp, Imm,Imm_ext);
destinationRegister dr(	clk,RegDst,Rd,Rt,Rd_next);	 
BTA bt(	clk,PC_n,Imm_ext,bta); 
calculatePCNext NPC(clk,PCSrc,PC_c,bta,offset,PC_n);

initial begin
        // Initialize signals
        clk = 0;
    /*	
        // Test case 1: R- type
        #30 ; 
		busW = 32'h12579342	;
		RegWR = 0;	
		RegDst = 0;	
		PCSrc = 2'b00;
        $monitor("fetched instruction: %h", instructionf);
		$monitor("PC curr : %h", PC_c);  
		$monitor("PC next : %h", PC_n);
        // Now we will process the instruction and print registers values  
		$monitor("Opcode: %h", opcode);
		$monitor("Rs: %h", Rs);  
		$monitor("Rt: %h", Rt);
		$monitor("Rd: %h", Rd);  
		$monitor("Imm: %h", Imm);
		$monitor("mode: %h", mode);  
		$monitor("offset: %h", offset);	  
		
		$monitor("BUSA: %h", busA);
		$monitor("BUSB: %h", busB);  	
		
		$monitor("Rd_next: %h", Rd_next); 
		
		$monitor("BTA: %h", bta);
		PC_c = PC_n; 
		#30 ;   
		*/

		
		
        // Test case2 ---> Jtype   
       	#30 ;
		busW = 32'h12573221	;
		RegWR = 0;	
		extOp = 0;	
		RegDst = 1;
		PCSrc = 2'b10; 
		
        $monitor("fetched instruction: %h", instructionf);
		$monitor("PC curr : %h", PC_c);  
		$monitor("PC next : %h", PC_n); 
		
         // Now we will process the instruction and print registers values  
		$monitor("Opcode: %h", opcode);
		$monitor("Rs: %h", Rs);  
		$monitor("Rt: %h", Rt);
		$monitor("Rd: %h", Rd);  
		$monitor("Imm: %h", Imm);
		$monitor("mode: %h", mode);  
		$monitor("offset: %h", offset);	
		
		$monitor("BUSA: %h", busA);
		$monitor("BUSB: %h", busB);  
		
		$monitor("Imm_ext: %h", Imm_ext); 
		$monitor("Rd_next: %h", Rd_next); 
		
		$monitor("BTA: %h", bta);
		
		 PC_c = PC_n;
		 #100 ;
		
		
		
		/*
		
		// Text case3 ---> I-type 
		
		#50;	
		busW = 32'h12573221	;
		RegWR = 0;	
		extOp = 0;	
		RegDst = 1;
		PCSrc = 2'b10;
        $monitor("fetched instruction: %h", instructionf);
		$monitor("PC curr : %h", PC_c);  
		$monitor("PC next : %h", PC_n);
         // Now we will process the instruction and print registers values  
		$monitor("Opcode: %h", opcode);
		$monitor("Rs: %h", Rs);  
		$monitor("Rt: %h", Rt);
		$monitor("Rd: %h", Rd);  
		$monitor("Imm: %h", Imm);
		$monitor("mode: %h", mode);  
		$monitor("offset: %h", offset);	
		
		$monitor("BUSA: %h", busA);
		$monitor("BUSB: %h", busB);  
		
		$monitor("Imm_ext: %h", Imm_ext); 
		$monitor("Rd_next: %h", Rd_next);
		
		$monitor("BTA: %h", bta);
									   
       //  #20;	 
       */ $finish;
    end

endmodule