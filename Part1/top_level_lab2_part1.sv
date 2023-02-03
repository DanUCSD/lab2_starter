// CSE140L     top level DUT for Lab 2 part 1
// Bryan Chin, UCSD - rights reserved
// for use only for those enrolled in UCSD cse140L
// see Structural Diagram in Lab2 assignment writeup
// fill in missing connections and parameters, equations, etc.
module top_level_lab2_part1(
    input        Reset,
                 Timeset, // manual buttons
                 Alarmset, //    (five total)
                 Minadv,
                 Hrsadv,
                 Alarmon,
                 Pulse, // assume 1/sec. -- this is our digital clk
// 6 decimal digit display (7 segment)
    output [6:0] S1disp, S0disp, // 2-digit seconds display
                 M1disp, M0disp, 
                 H1disp, H0disp,
    output logic AMorPM, // AMorPM (=1 when PM) 
    output logic Buzz);              // alarm sounds

   logic [6:0] TSec, TMin, THrs;   // time 
   logic       TPm;                // time PM
   logic [6:0] AMin, AHrs;         // alarm setting
   logic       APm;                // alarm PM
   
     
  logic[6:0] Min, Hrs;                     // drive Min and Hr displays
  logic Smax, Mmax, Hmax,          // "carry out" from sec -> min, min -> hrs, hrs -> days
        TMen, THen, TPmen, AMen, AHen, AHmax, AMmax, APmen;    // respective counter enables
  logic         Buzz1;             // intermediate Buzz signal

   // be sure to set parameters on ct_mod_N modules
   // seconds counter runs continuously, but stalls when Timeset is on 
   ct_mod_N #(.N()) Sct(
        .clk(Pulse), .rst(Reset), .en(), .ct_out(TSec), .z(Smax)
   );

   // minutes counter -- runs at either 1/sec or 1/60sec
   // make the appropriate connections. Make sure you use
   // a consistent clock signal. Do not use logic signals as clocks 
   // (EVER IN THIS CLASS)
   ct_mod_N #(.N()) Mct(
    .clk(), .rst(), .en(TMen), .ct_out(TMin), .z(Mmax)
   );

   // hours counter -- runs at either 1/sec or 1/60min
   ct_mod_N #(.N()) Hct(                          
        .clk(), .rst(), .en(), .ct_out(), .z()
   );

   // AM/PM state  --  runs at 1/12 sec or 1/12hrs
   regce TPMct(.out(), .inp(), .en(),
               .clk(), .rst());



// alarm set registers -- either hold or advance 1/sec
  ct_mod_N #(.N()) Mreg(
    .clk(), .rst(), .en(AMen), .ct_out(AMin), .z()
   ); 

  ct_mod_N #(.N()) Hreg(          
    .clk(), .rst(), .en(), .ct_out(), .z()
  ); 

   // alarm AM/PM state 
   regce APMReg(.out(APm), .inp(), .en(),
               .clk(), .rst());


   // display drivers (2 digits each, 6 digits total)
   lcd_int Sdisp(
    .bin_in    (TSec)  ,
        .Segment1  (S1disp),
        .Segment0  (S0disp)
   );

   lcd_int Mdisp(
    .bin_in    () ,
        .Segment1  (),
        .Segment0  ()
        );

  lcd_int Hdisp(
    .bin_in    (),
        .Segment1  (),
        .Segment0  ()
        );

   // counter enable control logic
   // create some logic for the various *en signals (e.g. TMen)
 
  
   
   // display select logic (decide what to send to the seven segment outputs) 
    
   alarm a1(
           .tmin(), .amin(), .thrs(), .ahrs(), .tpm(), .apm(), .buzz()
           );

  
   // generate AMorPM signal (what are the sources for this LED?)/
 

endmodule