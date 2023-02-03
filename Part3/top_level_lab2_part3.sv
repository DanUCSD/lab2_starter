// CSE140L  
// see Structural Diagram in Lab2 Part 3assignment writeup
// fill in missing connections and parameters
module top_level_lab2_part3(
  input Reset,
        Timeset,    // manual buttons
        Alarmset,   //  (five total)
    Minadv,
    Hrsadv,
        Dayadv,
        Monthadv,
        Dateadv,
    Alarmon,
    Pulse,      // assume 1/sec.
    DorT,
// 6 decimal digit display (7 segment)
  output[6:0] S1disp, S0disp,      // 2-digit  display
              MD1disp, MD0disp,    // 2 digit display  minutes/date
              HM1disp, HM0disp,     // 2-digit display hours/month
               DayLED,             // day of week LED
   // date display
  output logic AMorPM,              
  output logic Buzz);            // alarm sounds


//... Fill in with part3 implementation
endmodule
