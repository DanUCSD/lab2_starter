/* maps binary hours, minutes, seconds to 
binary coded decimal and then to
7-segment display drivers 
      _
     |_|  {center, upper left, lower right,
     |_|   bottom, lower right, upper right,
       top}
*/
module lcd_int(
  input[6:0] bin_in,
  output logic [6:0] Segment1,
                     Segment0);

  logic[6:0] bin0;        // less significant digit
  assign bin0 = bin_in % 10;  // mod10   
  logic[6:0] bin1;        // more significant digit
  assign bin1 = bin_in/10;    // floor (truncate toward -infinity)
  
  always_comb case(bin0) 
    4'b0000 : Segment0 = 7'b1000000;
    4'b0001 : Segment0 = 7'b1111001;
    4'b0010 : Segment0 = 7'b0100100;
    4'b0011 : Segment0 = 7'b0110000;
    4'b0100 : Segment0 = 7'b0011001;
    4'b0101 : Segment0 = 7'b0010010;
    4'b0110 : Segment0 = 7'b0000010;
    4'b0111 : Segment0 = 7'b1111000;
    4'b1000 : Segment0 = 7'b0000000;
    4'b1001 : Segment0 = 7'b0011000;
    default : Segment0 = 7'h00;
  endcase
    always_comb case(bin1) 
    4'b0000 : Segment1 = 7'b1000000;
    4'b0001 : Segment1 = 7'b1111001;
    4'b0010 : Segment1 = 7'b0100100;
    4'b0011 : Segment1 = 7'b0110000;
    4'b0100 : Segment1 = 7'b0011001;
    4'b0101 : Segment1 = 7'b0010010;
    4'b0110 : Segment1 = 7'b0000010;
    4'b0111 : Segment1 = 7'b1111000;
    4'b1000 : Segment1 = 7'b0000000;
    4'b1001 : Segment1 = 7'b0011000;
    default : Segment1 = 7'h00;
  endcase

endmodule
