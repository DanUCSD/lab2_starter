// CSE140 lab 2  
// How does this work? How long does the alarm stay on? 
// (buzz is the alarm itself)
module alarm(
  input [6:0]  tmin,
               amin,
               thrs,
               ahrs,
  input        tpm, 
  input        apm, 
  output logic buzz
);

  assign buzz = (tmin == amin) && (thrs == ahrs) && (tpm == apm);


endmodule