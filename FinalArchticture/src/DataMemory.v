////////////////////////////////////////////////////////////////////////////////
/* 					   
This is the DataMemory - 32bit data memory

INPUTS:-
	address: 32-Bit address input port.
 	data_in: 32bit input
	MemWr: 1bit control signal for memory write	
	MemRd: 1bit control signal for memory read
	clk: 1bit clock signal

OUTPUTS:-
	data_out: 32bit output

The 'WriteData' value is written into the address in the positive clock edge 
*/
////////////////////////////////////////////////////////////////////////////////

module DataMemory(address, data_in, clk, MemWr, MemRd, data_out);

	input [31:0] address;  //31bits address	 
	input [31:0] data_in;  //31bits input data	
	input MemRd, MemWr,clk; //1bit inputs
  
  	output reg[31:0] data_out; // Contents of memory location at Address
	
	reg [31:0] Memory[0:100]; //memory contains 16slot and each one is 32bits long (16*32bit=512bits) since word size =4bytes=32bit
	
	// Define address ranges for data and stack segments
    parameter DATA_SEGMENT_START = 0;
    parameter DATA_SEGMENT_END = 255;
    parameter STACK_SEGMENT_START = 256;
    parameter STACK_SEGMENT_END = 511;	 
		
    //reg [31:0] Memory1[0:255];   //It includes data segments   
    //reg [31:0] Memory2[256:511]; //It includes 


	always @(posedge clk) //on the positive/rising edge --write on data memory
   	begin  
		$readmemh("memory.hex",Memory);
		if(MemWr == 1) begin  //write the input on memory address = store operation
			Memory[address] = data_in;
			$writememh("memory.hex",Memory);
		end	
	end
	
	
	always @(address or data_in) //if the input data changes or the address --read memmory 
   	begin	
   		if(MemRd == 1)  //read the address from memory to output = load operation 
			data_out = Memory[address];
		else
            data_out =  32'h00000000; //clear the output - inorder to not take the last data_out	
	end
	
endmodule