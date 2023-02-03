// testbench for lab2
`include "lab2_display_tb.sv"
module lab2_part3_tb();
  logic Reset = 1,
        Clk = 0,
        Timeset = 0,
        Alarmset = 0,
		Minadv = 0,
		Hrsadv = 0,
		Dayadv = 0,
		Dateadv = 0,
		Monthadv = 0,
		Alarmon = 1,
		Pulse = 0,
    DorT = 1;
		
  wire[6:0] HM1disp, HM0disp,
            MD1disp, MD0disp,
	    S1disp, S0disp, 
	    DayLED;
  wire Buzz;
  wire AMorPM;


  top_level_lab2_part3 top(.*); // (.Reset(Reset),....)

  initial begin
	#  2ns  Reset    = 0;
    #  2ns
    $display("5': before setting. '010100000', Jan 1, ",$time);
    display_tb (
		.leds({AMorPM, DayLED, 1'b0, Buzz}),
		.seg_d(HM1disp),      .seg_e(HM0disp), 
		.seg_f(MD1disp),      .seg_g(MD0disp), 
		.seg_h(S1disp),      .seg_i(S0disp));
	#  2ns  Timeset  = 1;
		    Dateadv  = 1;
		    Monthadv = 1;
	# 22ns  Monthadv = 0;   //month: 12
    # 38ns  Dateadv  = 0;   //date: 31
			Timeset  = 0;
    #  2ns
    $display("5':after setting,'1231', manually increment date/month successful ",$time);
    display_tb (
		.leds({AMorPM, DayLED, 1'b0, Buzz}),
		.seg_d(HM1disp),      .seg_e(HM0disp), 
		.seg_f(MD1disp),      .seg_g(MD0disp), 
		.seg_h(S1disp),      .seg_i(S0disp));

    repeat(24) #7200ns;    //24 hours
    display_tb (
		.leds({AMorPM, DayLED, 1'b0, Buzz}),
		.seg_d(HM1disp),      .seg_e(HM0disp), 
		.seg_f(MD1disp),      .seg_g(MD0disp), 
		.seg_h(S1disp),      .seg_i(S0disp));


	#  2ns  Timeset  = 1;
		    Dateadv  = 1;
		    Monthadv = 1;
	#  2ns  Monthadv = 0;   //month 2
    # 52ns  Dateadv  = 0;  //date: 28
			Timeset  = 0;
			  
    #  2ns
    $display("5'---------------testing mod-----------");
    $display("testing Feb has 28 days:'0228' ",$time);
    display_tb (
		.leds({AMorPM, DayLED, 1'b0, Buzz}),
		.seg_d(HM1disp),      .seg_e(HM0disp), 
		.seg_f(MD1disp),      .seg_g(MD0disp), 
		.seg_h(S1disp),      .seg_i(S0disp));

    repeat(24) #7200ns; //24hours
	
    $display("0301");
    display_tb (
		.leds({AMorPM, DayLED, 1'b0, Buzz}),
		.seg_d(HM1disp),      .seg_e(HM0disp), 
		.seg_f(MD1disp),      .seg_g(MD0disp), 
		.seg_h(S1disp),      .seg_i(S0disp));


	#  2ns  Timeset  = 1;
			Dateadv  = 1;
			Monthadv = 1;
	#  2ns  Monthadv = 0;  //month 4
    # 56ns  Dateadv = 0; //date: 30
	   	    Timeset  = 0;
    #  2ns
    $display("testing April has 30 days: '0430' ",$time);
    display_tb (
		.leds({AMorPM, DayLED, 1'b0, Buzz}),
		.seg_d(HM1disp),      .seg_e(HM0disp), 
		.seg_f(MD1disp),      .seg_g(MD0disp), 
		.seg_h(S1disp),      .seg_i(S0disp));

    repeat(24) #7200ns; //24hours
    $display("5 points: 0501 ",$time);
    display_tb (
		.leds({AMorPM, DayLED, 1'b0, Buzz}),
		.seg_d(HM1disp),      .seg_e(HM0disp), 
		.seg_f(MD1disp),      .seg_g(MD0disp), 
		.seg_h(S1disp),      .seg_i(S0disp));

	#  2ns  Timeset  = 1;
			Dateadv  = 1;
			Monthadv = 1;
	#2ns // should display time 

    display_tb (
		.leds({AMorPM, DayLED, 1'b0, Buzz}),
		.seg_d(HM1disp),      .seg_e(HM0disp), 
		.seg_f(MD1disp),      .seg_g(MD0disp), 
		.seg_h(S1disp),      .seg_i(S0disp));

	 
	#100ns  $stop; 
  end 
  
  always begin  // period is 2 ns
    #1ns Pulse = 1;				 // #500ps Pulse = 1;	  1ns      500ps ==> 1ns	  5ns  
	#1ns Pulse = 0;				 // #500ps Pulse = 0;								  5ns
  end
endmodule
