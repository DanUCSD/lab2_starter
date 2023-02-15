// CSE140L  
// see Structural Diagram in Lab2 Part 3assignment writeup
// fill in missing connections and parameters
module top_level_lab2_part3(
  input Reset,
        Timeset, 	  // manual buttons
        Alarmset,	  //	(five total)
        Minadv,
        Hrsadv,
        Dayadv,
        Monthadv,
        Dateadv,
        Alarmon,
        Pulse,		  // assume 1/sec.
        DorT,			   
// 6 decimal digit display (7 segment)
  output[6:0] S1disp, S0disp, 	   // 2-digit seconds display
              MD1disp, MD0disp, 
              HM1disp, HM0disp,
              DayLED,
  output logic AMorPM,            // Added by Arpita 
  output logic Buzz);	           // alarm sounds
  
   logic [6:0] TSec, TMin, THrs;   // time 
   logic       TPm;                // time PM
   logic [6:0] AMin, AHrs;         // alarm setting
   logic       APm;                // alarm PM
   logic [2:0] TDay;               // Part 2 Day of the Week
   logic [5:0] TDate;              // Part 3 Date
   logic [4:0] TMonth;             // Part 3 Month
   logic [6:0] dummyS1, dummyS0;   // Part 3 seconds display for DorT
   
     
  logic[6:0] Min, Hrs;                     // drive Min and Hr displays
  logic Smax, Mmax, Hmax, Dmax,         // "carry out" from sec -> min, min -> hrs, hrs -> days
        TMen, THen, TPmen, AMen, AHen, AHmax, AMmax, APmen,    // respective counter enables
        Dayen,
        Dateen, Monthen,                 // date and month ct enablers
        Datemax;               // datemax for roll over, monthmax just in case (?)
        logic         Buzz1;             // intermediate Buzz signal

   ct_mod_N #(.N()) Sct(
         .clk(Pulse), .rst(Reset), .en(!Timeset), .ct_out(TSec), .z(Smax)    
   );

        // if Smax is true (if we need to increment minutes), then run this
   assign TMen = Smax || (Timeset && Minadv);
   ct_mod_N #(.N()) Mct(
         .clk(Pulse), .rst(Reset), .en(TMen), .ct_out(TMin), .z(Mmax)
   );


   assign THen = (Mmax && Smax) || (Timeset && Hrsadv);  // It resets to 00 instead of staying at 12.
   ct_mod_N #(.N(12)) Hct(                          
         .clk(Pulse), .rst(Reset), .en(THen), .ct_out(THrs), .z(Hmax)
   );


   assign TPmen = (Smax && Mmax && Hmax) || (Timeset && Hmax && Hrsadv);
   regce TPMct(.out(TPm), .inp(!TPm), .en(TPmen),
               .clk(Pulse), .rst(Reset));


  assign AMen = Alarmset && Minadv;
  ct_mod_N #(.N()) Mreg(
    .clk(Pulse), .rst(Reset), .en(AMen), .ct_out(AMin), .z(AMmax)
   ); 

  assign AHen = Alarmset && Hrsadv;
  ct_mod_N #(.N(12)) Hreg(          
    .clk(Pulse), .rst(Reset), .en(AHen), .ct_out(AHrs), .z(AHmax)
  ); 

   // alarm AM/PM state 
   assign APmen = Alarmset && AHmax && Hrsadv;
   regce APMReg(.out(APm), .inp(!APm), .en(APmen),
               .clk(Pulse), .rst(Reset));

   // display drivers (2 digits each, 6 digits total)
   lcd_int Sdisp(
    .bin_in    (TSec)  ,
        .Segment1  (dummyS1),               // if display date, send seconds into the shadow realm
        .Segment0  (dummyS0)
   );

	assign S1disp = DorT ? 7'b1111111 : dummyS1;
	assign S0disp = DorT ? 7'b1111111 : dummyS0;
	
   lcd_int Mdisp(
    .bin_in    (DorT ? TDate + 1: (Alarmset ? AMin: TMin)) ,   // if display date, swap for date
        .Segment1  (MD1disp),
        .Segment0  (MD0disp)
        );
		  
		  
  lcd_int Hdisp(
    .bin_in    (DorT ? TMonth + 1 : (Alarmset ? AHrs == 0 ? 12 : AHrs: THrs == 0 ? 12: THrs)),
        .Segment1  (HM1disp),                                // if display date, swap for month
        .Segment0  (HM0disp)
        );
        
   alarm a1(
           .tmin(TMin), .amin(AMin), .thrs(THrs), .ahrs(AHrs), .tpm(TPm), .apm(APm), .buzz(Buzz1)
           );

	assign Buzz = Buzz ? Alarmon : Alarmon && Buzz1;
 
	assign AMorPM = Alarmset ? APm : TPm;

  // Day LED, Dayen'ed when dayadv or (pm and (natural roll over or hrsadv roll over or minadv roll over))

  assign Dayen = (TPm && Smax && Mmax && Hmax) || (Timeset && Dayadv);
  ct_mod_N #(.N(7)) Dct(                          
         .clk(Pulse), .rst(Reset), .en(Dayen), .ct_out(TDay), .z(Dmax)
   );

	assign DayLED = TDay == 0 ? 7'b1000000 : TDay == 1 ? 7'b0100000 : TDay == 2 ? 7'b0010000 : TDay == 3 ? 7'b0001000 :
						      TDay == 4 ? 7'b0000100 : TDay == 5 ? 7'b0000010 : TDay == 6 ? 7'b0000001 : 7'h00;
      
  
  // Date and Month

      assign Dateen = (TPm && Smax && Mmax && Hmax) || (Timeset && Dateadv);              // natural roll over + timeset
      ct_mod_D Dtct(
            .clk(Pulse), .rst(Reset), .en(Dateen), .TMo0(TMonth), .ct_out(TDate), .z(Datemax)
      );

      assign Monthen = (Datemax && TPm && Smax && Mmax && Hmax) || (Timeset && Monthadv); // natural roll over + timeset
      ct_mod_N #(.N(12)) Mnct(
            .clk(Pulse), .rst(Reset), .en(Monthen), .ct_out(TMonth), .z()
      );
  
      

endmodule
