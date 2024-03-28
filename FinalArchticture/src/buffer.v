module GenericBuffer #(
   parameter w = 8 // Default width is 8 bits
)(
   input clk,
   input wire [w-1:0] in,
   output reg [w-1:0] out
);

   always @(posedge clk) begin
      // Assign the input signal to the output
      out <= in;
      //$monitor("out is : %h", out); 
   end

endmodule
