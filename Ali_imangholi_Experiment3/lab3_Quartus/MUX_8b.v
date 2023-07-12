`timescale 1ns/1ns
module MUX_8b(input [7:0]MUX_in_1_ , input [7:0]MUX_in_2_ ,input select , output [7:0]MUX_out_);
assign MUX_out_ = (select == 1'b1) ? (MUX_in_2_): MUX_in_1_;
endmodule
