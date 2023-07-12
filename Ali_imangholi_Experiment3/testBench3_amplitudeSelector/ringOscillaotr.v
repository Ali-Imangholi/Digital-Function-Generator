`timescale 1ps/1ps
module ringOsillotor #(parameter invDelay ,parameter N)(input enable , output reg clk);
assign clk = 1'b0;
always @ * begin
	while (enable) begin
	repeat(N)#invDelay clk = ~clk;
	end
end

endmodule






module tbRingOsillotor();
reg ENABLE;
wire CLK;
ringOsillotor #(1600 , 5) I1(ENABLE , CLK);
initial begin
ENABLE=1;
#8000000;
end
endmodule
