module CPU(clock);	
	
	input wire clock;	
	 
	//main control signals
	wire [1:0] ALUSrc,STop;
	wire ExtOp,RdWB,MemWr,MemRd,MemIn,MemAddress,RegWRd,RegWRs;
	
	//Control signals
	wire CarryFlag,ZeroFlag;
	wire [1:0] PCSrc;
	wire RegWrs,RegWrd; 
	wire [31:0] memory_out;
	
	//Inputs of Instruction memory
	reg [31:0] PC; 
	reg stages;
	 
	//Outputs of Instruction memory  
	wire [31:0] instruction; 
	wire [31:0] instruction_buf;
	
	//Instruction Fetch
	wire [31:0] PC_next;
	wire [31:0] branchTargetAddress;
	wire [31:0] bta_buf;
	wire [31:0] PC_nextbuf;	  	
	
	// IR
	wire [5:0] Op;
	wire [3:0] Rs1,Rs2,Rd;
	wire [15:0] Imm16;	
	wire [1:0]  mode;
	wire [25:0] offset;
	
	wire [31:0] BusA,BusA_buf; //Rs1
	wire [31:0] BusB,BusB_buf; //Rs2
	wire [31:0] Imm,Imm_buf;
	wire [3:0] Rd_buf;	 //address of Rd
	
	wire [31:0] BusWs;
	wire [31:0] BusWd;
	
	// alu
	wire [31:0] alu_operand2;		 
	wire [1:0] AluOp ; //2bits selector for 4 different operations	
	wire [31:0] alu_result;    
	wire [31:0] Rs1_incremented; 
	wire [31:0] alu_result_buff;
	wire [31:0] Rs1_incremented_buff;
	wire [31:0] BusWd_buff; 
	wire ZeroFlag_buff;
	wire CarryFlag_buff; 
	
	// MEM
	wire [31:0] sp; //stack top pointer
	wire [31:0] sp_incremented;	 
	wire [31:0] sp_decremented;	
	wire [31:0] new_sp;		
	
	wire [31:0] memory_address;
	wire [31:0] memory_in;	 
	wire [31:0] alu_result_buff2;
	wire [31:0] memory_out_buff2; 
	wire [31:0] new_Rd;
	
	wire [31:0] busD;	
	reg	[31:0] registers [0:15];
	
	// state
	reg [2:0] state, nextstate;
	reg reset,temp;
	
	parameter FETCH = 3'b000; // State 0 
	parameter DECODE = 3'b001; // State 1
	parameter EXECUTE = 3'b010; // State 2 
	parameter MEM = 3'b011; // State 3
	parameter WRITEBACK = 3'b100; // State 4 
	
	
	initial begin 
		$readmemh("data1.hex",registers);
        //PC = 32'hFFFFFFFF; // Set the initial value of PC to 0x000
		PC	= 32'h00000000;
		state = FETCH; 	
    end
	
	
			
			
	// next state logic
always @(*)
    case(state)
        FETCH: nextstate <= DECODE;
        DECODE: begin 
			// sw & push & pop  
			if(  Op == 15 || Op == 16)begin
				nextstate <= MEM;
			end	
			// j & call & ret
			else if (Op ==12 ||  Op == 13 || Op == 14)begin
				nextstate <= FETCH;
			end	
			// and & andi & add & addi & lw & br
			else begin
			    nextstate <= EXECUTE; 
			end 
			$monitor("next state after decode: %h",nextstate);
        end

        EXECUTE: begin
			// and & andi & add & addi  
			if(Op == 0 ||  Op == 1 || Op == 2 ||  Op == 3 || Op == 4)begin
				nextstate <= WRITEBACK;
			end	
			// branch
			else if (Op == 8 ||  Op == 9 || Op == 10 || Op == 11)begin
				nextstate <= FETCH;
			end	
			// sw , load
			else begin
			    nextstate <= MEM; 
			end 
			$monitor("next state after exec: %h",nextstate);
        end

        MEM: begin
            // sw
			if (Op == 7)begin
				nextstate <= FETCH;
			end	
			// load
			else begin
			    nextstate <= WRITEBACK; 
			end 
			$monitor("next state after mem: %h",nextstate);  
        end

        WRITEBACK: nextstate <= FETCH;

        default: nextstate <= FETCH;
    endcase

	// next state	
	always @(posedge clock) begin
		if(nextstate == FETCH)begin   
			temp <= 1;
			reset <= temp;
		end
		else reset <= 0;
	end	 
	
	// state register
	always @(posedge clock)begin
		if(reset) state <= FETCH;
		else state <= nextstate;
	end		
		
	
	// reset
	always @(posedge reset) begin
		//if(reset) begin
			//PC <= (PC == 32'hFFFFFFFF) ? 32'h00000000 : PC_next;
			PC <= PC_next; // Update PC at each positive edge of the clock (replace PC_nextbuf with your actual update logic)
			//assign RegWRd = 0;
			//RegWRs <= 0;  
			//MemWr <= 0;
			//MemRd <= 0;	
			//alu_result <= 0;
			//ZeroFlag <= 0;
			//CarryFlag <= 0;
			
		//end
	end	
	
	
	
//----------------------stage1: IF
	//Determine PCSrc value
	PCControl PCC(Op,CarryFlag,ZeroFlag,PCSrc);		   
	
	//Get PC next value
	calculatePCNext NPC(PCSrc,PC,bta_buf,offset,memory_out,PC_next);
	
	// Load Pc next to buffer
	GenericBuffer #(32) NPCC (clock, PC_next ,PC_nextbuf);
	
	// Fetch Instruction 
	INST_MEM ins_mem(PC,instruction); 	
	
	//always @(reset) begin
   //     PC <= PC_next; // Update PC at each positive edge of the clock (replace PC_nextbuf with your actual update logic)
    //end
    
	// Load instruction to buffer
	GenericBuffer #(32) Inst (clock, instruction, instruction_buf);
	
	
//-----------------------stage2: ID	 
	
	// Process Instruction (decode it)
	PI ins(instruction_buf,Op,Rd,Rs2,Rs1,Imm16,mode,offset);
	
	//calculate stages
	//increment stages count
	
	// Check Immediate extension
	//Extender ex(Imm16,ExtOp,Imm); 
	Ext ex(ExtOp,Imm16,Imm);
	GenericBuffer #(32) Immm (clock, Imm, Imm_buf); //Load extended immediate to buffer
		
	// Get Registers from registers file
	registerFile rf(clock,RegWRd,RegWRs,Rd,Rs2,Rs1,BusWd,BusWs,BusA,BusB);	
	GenericBuffer #(32) BUSA (clock, BusA, BusA_buf);  //Load BusA and BusB to buffers 
	GenericBuffer #(32) BUSB (clock, BusB, BusB_buf);
	GenericBuffer #(4) RD22  (clock, Rd, Rd_buf); //Load destination register to buffer
	
	// Calculate Branch target address
	BTA bt(PC,Imm,branchTargetAddress); 
	GenericBuffer #(32) BTAAA (clock, branchTargetAddress, bta_buf); //Load BTA to buffer

	
	//intilize the control signals for the instruction
	MainControlUnit control_unit(Op,ALUSrc,RdWB,ExtOp,MemWr,MemRd,MemIn,MemAddress,STop,RegWRd,RegWRs); 
	
	
	//execute stage	  
     
	assign BusWd = registers[Rd_buf];
		
	mux4x1 alu_operand2_mux(BusB_buf,Imm_buf,BusWd,0,ALUSrc,alu_operand2); 	//compute the alu operand2	
	ALU32_control alu_control (Op,AluOp);	                      //compute the alu operation selector 
	ALU32 alu (BusA_buf,alu_operand2,AluOp, alu_result,ZeroFlag,CarryFlag);    //compute the alu result 
	Incrementer inrem(BusA_buf, Rs1_incremented);                        //increment the value of Rs1 
			
	//increment the pc					
	//wire [31:0] branch_PC_address;
	//Adder(PC,immediate_extended,branch_PC_address);  
																   
	//buffer between execute stage and memory access stage 	 
	EX_MA_Buffer ex_ma_buffer(clock, alu_result, ZeroFlag, CarryFlag, Rs1_incremented, BusWd,
	alu_result_buff, ZeroFlag_buff, CarryFlag_buff, Rs1_incremented_buff, BusWd_buff); 
								  				
								  
								  
	//memory access stage	 
	
	
	Incrementer increm(sp, sp_incremented);   //increment the stack pointer - used in push stack, to increase the top value
	decrementer decrem(sp, sp_decremented);	  //decrement the stack pointer - used in pop stack, to decrease the top value
	mux4x1 muxStack(sp_incremented,sp_decremented,sp, 0,STop,new_sp);	//update stack pointer
	StackPointer stack_pointer(new_top,clock, sp); 	//stack pointer
	
	
	
	
	mux2x1 memory_address_mux(alu_result_buff,sp,MemAddress, memory_address); //take memory address	  	
	mux2x1 memory_input_mux(BusWd_buff,PC_next,MemIn, memory_in);	         //take memory input 
	DataMemory data_memory(memory_address,memory_in,clock,MemWr,MemRd, memory_out);	//access data memory
	MA_WB_Buffer ma_wb_buffer(clock,alu_result_buff, memory_out, alu_result_buff2,memory_out_buff2);  //write the memory stage output to buffer
	

	//write back stage		
	
	mux2x1 wb_mux(alu_result_buff2,memory_out_buff2,RdWB, new_Rd);
	registerFile rf2(clock,RegWRd,RegWRs,Rd,Rs2,Rs1,new_Rd,Rs1_incremented_buff,BusA,BusB);

	
endmodule	