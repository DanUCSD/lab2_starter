// CSE140L  
// What does this do? 
// When does "z" go high? 
module ct_mod_D(
  input clk, rst, en,
  input[6:0] TMo0,
  output logic[6:0] ct_out,
  output logic      z);

  always_ff @(posedge clk)
    if(rst)
	  ct_out <= 0;
	else if(en)
	  case(TMo0)
        1:        ct_out <= (ct_out+1)%28;  // Feb
        3,5,8,10: ct_out <= (ct_out+1)%30;
        default:  ct_out <= (ct_out+1)%31;
      endcase  	  

  always_comb case(TMo0)
    1:        z = ct_out==27;
    3,5,8,10: z = ct_out==29;
    default:  z = ct_out==30;
  endcase
endmodule



