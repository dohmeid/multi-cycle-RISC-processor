module CPU_tb();
	
	//Parameters
  	parameter TIME_SCALE = 1ns;

	reg clock;
	CPU myCPU(
		.clock(clock)
	); 
	
   //Clock generation
   initial begin
     clock = 0;
     forever #((TIME_SCALE / 2)) clock = ~clock;
   end
	
	/*always
	begin
	    #30 clock = ~clock;
	end	*/

endmodule