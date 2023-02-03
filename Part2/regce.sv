// CSE140L
// clock enabled register
module regce #(parameter WIDTH=1)(
  output logic [WIDTH-1:0] out,
  input logic [WIDTH-1:0]  inp,
  input clk, rst, en);

  always_ff @(posedge clk)
    if(rst)
      out <= 0;
    else if(en)
      out <= inp;
    else
      out <= out;
endmodule

