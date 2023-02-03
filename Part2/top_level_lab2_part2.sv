// CSE140L  
// see Structural Diagram in Lab2 assignment writeup
// fill in missing connections and parameters
module top_level_lab2_part2(
  input Reset,
        Timeset, 	  // manual buttons
        Alarmset,	  //	(five total)
	Minadv,
	Hrsadv,
        Dayadv,
	Alarmon,
	Pulse,		  // assume 1/sec.			   
// 6 decimal digit display (7 segment)
  output[6:0] S1disp, S0disp, 	   // 2-digit seconds display
              M1disp, M0disp, 
              H1disp, H0disp,
              DayLED,
  output logic AMorPM,            // Added by Arpita 
  output logic Buzz);	           // alarm sounds
  
//... Fill in the logic to display part 2 requrements
endmodule
