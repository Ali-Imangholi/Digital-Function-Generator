`timescale 1ps/ 1ps

module waveFormGenerator(input clk, rst, input[2:0] waveSelect, output reg [7:0] waveForm);

reg[7:0] counter;  

reg[7:0] square_wave;

reg [7:0] reciprocal;

reg[7:0] saw_tooth;

reg[7:0] rhomboid;

reg rdy;

reg [31:0]counter32b;

reg [15:0] sqrtValue;

//////////////////////////////////////counter//////////////////////////////////////

always @(posedge clk, posedge rst)
  begin
    if (rst)
      begin
        counter <=0;
      end
    else
      counter<=counter + 1'b1;
end  

////////////////////////////////////////////////////////////////////////////////////
////////////////////square_wave  saw_tooth    rhomboid /////////////////////////////

always @(posedge clk, posedge rst)
  begin
    if (rst)
      begin
        square_wave <=0;
        reciprocal <=0;
        saw_tooth <=0;
        rhomboid <= 0;
      end
	 else 
		 begin
		 square_wave = (counter == 255)?~square_wave:square_wave;
		 saw_tooth = counter;
		 rhomboid = (counter > 127) ? ((counter % 2 == 1) ? counter: (255 - counter)): ((counter % 2 == 1) ?(255 - counter) :counter );
											
		 end
		
  end
  
////////////////////////////////////// sin(n) = sin(n-1) + 1/64 cos(n-1) //////////////////////////////////////
////////////////////////////////////// cos(n) = cos(n-1) - 1/64 sin(n) //////////////////////////////////////
reg signed [15:0] sine,cos;
reg signed [15:0] sine_n_m_1, cos_n_m_1;

always @*
  begin
  sine = sine_n_m_1 + (cos_n_m_1 >>> 6);
  cos = cos_n_m_1 - (sine >>> 6);
end


always@(posedge clk , posedge rst)
  begin
    if (rst)
      begin
        sine_n_m_1 <= 16'd0;
        cos_n_m_1 <= 16'd30000; 
      end
    else
      begin
        sine_n_m_1 <= sine;           ///recursive algorithm    sin(n-1) <------- sin(n)
        cos_n_m_1 <= cos;             ///recursive algorithm    cos(n-1) <------- cos(n)

      end
  end
////////////////////////////////////////sqrt/////////////////////////////////////////////
//
//assign counter32b = {{15{counter[15]}} , counter[15:0]};
//
//sqrt32 I1 (clk, rdy, reset, counter32b , sqrtValue); 
//
//
//////////////////////////////////////selectingPart//////////////////////////////////////
reg[15:0] sine_sh;
always @(*)
  begin
    case (waveSelect)
      3'b000  : waveForm <= rhomboid;
      3'b001  : begin sine_sh = sine[15:8] + 8'd127; waveForm = sine_sh[7:0]+ 8'd127; end
      3'b010  : waveForm <= square_wave;
      3'b011  : begin sine_sh = sine[15:8] + 8'd127; waveForm = (sine_sh[7:0] > 127)? 8'b0 : (sine_sh[7:0]); end
      3'b100  : waveForm <= saw_tooth;
      3'b101  : begin sine_sh = sine[15:8] + 8'd127; waveForm = (sine_sh[7:0] > 127) ? (sine_sh[7:0]): ~(sine_sh[7:0]); end
      3'b110  : begin sine_sh = sine[15:8] + 8'd127; waveForm = (counter % 2) ? (sine_sh[7:0]): ~(sine_sh[7:0]); end
      default : waveForm <= square_wave; 
    endcase
  end

endmodule
//sine_sh = sine[15:8] + 8'd127; waveForm = (sine_sh[7:0] > 127)? 8'b0 : (sine_sh[7:0]);
//waveForm = (counter==255)?16'b0 : (-1* $sqrt(~counter));