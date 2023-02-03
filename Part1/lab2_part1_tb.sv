// testbench for lab2 part 1 -- alarm clock
// hours, minutes, seconds 
`include "lab2_display_tb.sv"



module lab2_part1_tb #(parameter NS = 60, NH = 12);
  logic Reset = 1,
        Clk = 0,
        Timeset = 0,
        Alarmset = 0,
		Minadv = 0,
		Hrsadv = 0,
		Alarmon = 0,
		Pulse = 0;
  wire[6:0] S1disp, S0disp,
            M1disp, M0disp,
	        H1disp, H0disp;
  wire Buzz;
  wire AMorPM;

  top_level_lab2_part1 sd(.*); // (.Reset(Reset),....)
  initial begin
    $monitor("buzz = %b %t",Buzz,$time);
	#  1us  Reset    = 0;
	#  1us  Timeset  = 1;
	        Minadv   = 1;
	# 55us  Minadv   = 0;   //Minadv has passed 50
	       Hrsadv   = 1;
	#  7us  Timeset  = 0;  // Hrsadv has passed 7
		Hrsadv   = 0;
#1us
$display("display current time after setting");
    display_tb (
		.leds({AMorPM, 8'b0, Buzz}),
		.seg_d(H1disp),
		.seg_e(H0disp), .seg_f(M1disp),
		.seg_g(M0disp), .seg_h(S1disp),
    .seg_i(S0disp));
#1us  Alarmset = 1; 
#1us
$display("display alarm time before setting");
    display_tb (
		.leds({AMorPM, 8'b0, Buzz}),
		.seg_d(H1disp),    //display the alarm time
		.seg_e(H0disp), .seg_f(M1disp),
		.seg_g(M0disp), .seg_h(S1disp),
    .seg_i(S0disp));
	#  5us  Hrsadv   = 1;
	#  8us  Minadv   = 1;   //alarm hour: 8
		Hrsadv = 0;
	# 1us  Minadv   = 0;  // alarm min 1
     #1us Alarmon = 1;
$display("display alarm time after setting");
    display_tb (
		.leds({AMorPM, 8'b0, Buzz}),
		.seg_d(H1disp),    //display the alarm time
    .seg_e(H0disp), .seg_f(M1disp),
    .seg_g(M0disp), .seg_h(S1disp),
    .seg_i(S0disp));
	#  1us  Alarmset = 0;
#1us   //24 second past
$display("display current time after setting alarm");
    display_tb (
		.leds({AMorPM, 8'b0, Buzz}),
		.seg_d(H1disp),
    .seg_e(H0disp), .seg_f(M1disp),
    .seg_g(M0disp), .seg_h(S1disp),
    .seg_i(S0disp));
     for (int i=0; i<10; i++) begin
	# 60us;  //1 minute passted
	display_tb (
		    .leds({AMorPM, 8'b0, Buzz}),
		    .seg_d(H1disp),
		    .seg_e(H0disp), .seg_f(M1disp),
		    .seg_g(M0disp), .seg_h(S1disp),
		    .seg_i(S0disp));
     end

     // move ahead  12 hours
     #43200us;  // 12 * 60 * 60
     for (int i=0; i<10; i++) begin
	# 60us;  //1 minute passted
	display_tb (
		    .leds({AMorPM, 8'b0, Buzz}),
		    .seg_d(H1disp),
		    .seg_e(H0disp), .seg_f(M1disp),
		    .seg_g(M0disp), .seg_h(S1disp),
		    .seg_i(S0disp));
     end
     #3000ns  $stop;
  end 

  always begin  // period is 2 ns
    #500ns Pulse = 1;
	#500ns Pulse = 0;
  end
endmodule
