`timescale 1ps/1ps
module testBench_1_();


reg ENB;
reg [7:0] A_B_C_D_INPUT;
reg INIT;
reg RST;
reg [11:0] SW;
wire CLKOSILLATOR;
wire OUTPUTJKFLIPFLOP;
wire CO;
wire [7:0] OUTPUTWAVE;
wire MUXSELESCT;
wire 	SW_10_;
wire	SW_9_ ;
wire	SW_8_ ;
wire [9:0] MEMORYCOUNTER;
wire [2:0] WAVESELECT;
wire [7:0] ROMOUTPUT;
wire [7:0] WAVEFORMEGENERATOROUTPUT;

ringOsillotor #(28000 , 5)I1( ENB , CLKOSILLATOR);


waveForm_Generator I2(
	OUTPUTJKFLIPFLOP,
	A_B_C_D_INPUT,
	CLKOSILLATOR,
	INIT,
	CO,
	MUXSELESCT,
	SW,
	SW_10_,
	SW_9_,
	SW_8_,
	MEMORYCOUNTER,
	RST,
	OUTPUTWAVE,
	ROMOUTPUT,
        WAVEFORMEGENERATOROUTPUT,
	WAVESELECT);


initial begin
  A_B_C_D_INPUT = 8'b00000000;
  ENB=1; 
  RST=0;
  INIT = 1'b0;                                                                                                                                                 		                 	                 
  #5000 
  INIT = 1'b1;         
  #5000
  RST=1;
  #5000
  RST=0;
  #9999999
  SW = 12'b011100000000;
end
endmodule