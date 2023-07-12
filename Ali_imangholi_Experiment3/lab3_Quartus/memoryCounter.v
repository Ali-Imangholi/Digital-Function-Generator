`timescale 1ps/1ps
module memoryCounter(input clk , rst , output reg[9:0]count);
always@(posedge clk , posedge rst)begin
	if(rst)begin count <=0;end
	else if(count==10'b1111111111)begin count <=0; end

	else begin count <= count+1; end

end
endmodule
