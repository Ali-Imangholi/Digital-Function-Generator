`timescale 1ps/ 1ps

module amplitudeSelector(input[7:0] wavefrom, input[1:0] selectAmplitude, output[7:0] func_out);
  assign func_out = (selectAmplitude == 2'b00)? (wavefrom):
		    (selectAmplitude == 2'b01)? (wavefrom >> 1):
		    (selectAmplitude == 2'b10)? (wavefrom >> 2):
                    (selectAmplitude == 2'b11)? (wavefrom >> 3):(wavefrom);
endmodule
