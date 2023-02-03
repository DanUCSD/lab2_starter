// testbench for lab2 part 2 -- alarm clock
// days, hours, minutes, and seconds
`include "lab2_display_tb.sv"
module lab2_part2_tb #(parameter NS = 60, NH = 12);
  logic Reset    = 1,
        Timeset  = 0,
        Alarmset = 0,
		Minadv   = 0,
		Hrsadv   = 0,
        Dayadv   = 0,
		Alarmon  = 0,
		Pulse = 0;

  wire[6:0] S1disp, S0disp,
            M1disp, M0disp,
            H1disp, H0disp, DayLED;
  wire Buzz;
  wire AMorPM;
  int h1;
  top_level_lab2_part2 sd(.*);             // our DUT itself

  initial begin
    h1 = $fopen("list.txt");
//    $monitor("buzz = %b  at time %t",Buzz,$time);
	#  2us  Reset    = 0;
	#  1us  Timeset  = 1;
	        Minadv   = 1;
	# 58us  Minadv   = 0;
	        Hrsadv   = 1;
	#  7us  Hrsadv   = 0;
	        Dayadv   = 1;
	#  4us  Dayadv   = 0;
	        Timeset  = 0;
//	force (.sd.Min = 'h5);
//	release(.sd.Min);
     display_tb ( 
		  .leds({AMorPM, DayLED, 1'b0, Buzz}),
		  .seg_d(H1disp),
		  .seg_e(H0disp), .seg_f(M1disp),
		  .seg_g(M0disp), .seg_h(S1disp),
		  .seg_i(S0disp));
	$fdisplay(h1,"time should be set to (4=Friday)0858");
	#  1us  Alarmset = 1;
	        Hrsadv   = 1;
	#  8us  Hrsadv   = 0;
	#  1us  Minadv   = 1;
	#  3us  Minadv   = 0;
     display_tb ( 
		  .leds({AMorPM, DayLED, 1'b0, Buzz}),
		  .seg_d(H1disp),
		  .seg_e(H0disp), .seg_f(M1disp),
		  .seg_g(M0disp), .seg_h(S1disp),
		  .seg_i(S0disp));

        #  1us  Alarmset = 0; Alarmon = 1;
	$fdisplay(h1,"alarm should be set to 0903");
    for(int i=0; i<440; i++) 
	# 1us display_tb ( 
		  .leds({AMorPM, DayLED, 1'b0, Buzz}),
		  .seg_d(H1disp),
		  .seg_e(H0disp), .seg_f(M1disp),
		  .seg_g(M0disp), .seg_h(S1disp),
		  .seg_i(S0disp));

	repeat(23) #3600us; // 23 * 1 hour delay
     Alarmon = 0; #4us; 
    #3200us;
     Alarmon = 1;
   $fdisplay(h1,"(5=Saturday) Day increase successfully by hours reaching 24");
    for(int i=0; i<440; i++)
	#1us  display_tb ( 
		  .leds({AMorPM, DayLED, 1'b0, Buzz}),
		  .seg_d(H1disp),
		  .seg_e(H0disp), .seg_f(M1disp),
		  .seg_g(M0disp), .seg_h(S1disp),
		  .seg_i(S0disp));
    repeat(23) #3600us; // 24hours
    #3200us;
     display_tb ( 
		  .leds({AMorPM, DayLED, 1'b0, Buzz}),
		  .seg_d(H1disp),
		  .seg_e(H0disp), .seg_f(M1disp),
		  .seg_g(M0disp), .seg_h(S1disp),
		  .seg_i(S0disp));
//    repeat(23) #3600us; //24hours
//    #3200us;
     display_tb ( 
		  .leds({AMorPM, DayLED, 1'b0, Buzz}),
		  .seg_d(H1disp),
		  .seg_e(H0disp), .seg_f(M1disp),
		  .seg_g(M0disp), .seg_h(S1disp),
		  .seg_i(S0disp));
    for(int i=0; i<440; i++)
	#1us            display_tb ( 
		  .leds({AMorPM, DayLED, 1'b0, Buzz}),
		  .seg_d(H1disp),
		  .seg_e(H0disp), .seg_f(M1disp),
		  .seg_g(M0disp), .seg_h(S1disp),
		  .seg_i(S0disp));
    repeat(23) #3600us; // 24hours
    #3200us;
    for(int i=0; i<440; i++)
	#1us      display_tb ( 
		  .leds({AMorPM, DayLED, 1'b0, Buzz}),
		  .seg_d(H1disp),
		  .seg_e(H0disp), .seg_f(M1disp),
		  .seg_g(M0disp), .seg_h(S1disp),
		  .seg_i(S0disp));
  	#3500us  $stop;
//     #3500us  $finish;  // need to see what $finish does in interactive modelsim
     
  end 
  always begin
    #500ns Pulse = 1;
	#500ns Pulse = 0;
  end

endmodule
