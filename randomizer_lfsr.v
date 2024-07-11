//adapted LFSR from https://vlsicoding.blogspot.com/2014/07/verilog-code-for-4-bit-linear-feedback-shift-register.html

module randomizer (clk, restart, random);

input clk, restart;
output random;
 
wire clk, restart, feedback;
reg [2:0] random, count;

//initial begin
//  random = 1;
//end

assign feedback = ~(random[2] ^ random[1]);

always @(negedge clk) begin
  if (restart) begin
    count = 1;
    random = count;
  end
  else begin
    random = {random[1:0], feedback};
  end
  count = count + 1;
end

endmodule  
