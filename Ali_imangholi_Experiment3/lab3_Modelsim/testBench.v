`timescale 1ps/1ps
module tb();

reg CLK;
reg RST;
reg [2:0]WAVESELECT;
wire [7:0]out;

waveFormGenerator I1(CLK , RST, WAVESELECT, out);
initial begin
CLK = 0;
RST = 0;
#10
RST = 1;
#10
CLK = 1;
#10
RST = 0;
#10
CLK=0;
#10
WAVESELECT = 3'b011;
forever  #10 CLK = ~CLK;
end
endmodule