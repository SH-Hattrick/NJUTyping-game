module bgm(
    input clk,
    input en,
    input [7:0] kbdata,
    input [2:0] level,
	output reg[15:0] freq,
	output reg[6:0] volume,
    output reg reset = 0,
	output reg[7:0] cnt
);

reg [15:0] note [23:0];
//reg [7:0] cnt;
reg [31:0] clk_bgm_cnt = 0;
wire clk_bgm_vol;
reg [31:0] speedmax = 10000000;

initial
begin
	freq <= 0;
	volume <= 7'b1100000;
	$readmemh("note.txt",note,0,23);
end

/*
low
note[0]: C note[1]: C# note[2]: D note[3]: D# note[4]: E note[5]: F
note[6]: F# note[7]: G note[8]: G# note[9]: A note[10]: A# note[11]: B

mid
note[12]: C note[13]: C# note[14]: D note[15]: D# note[16]: E note[17]: F
note[18]: F# note[19]: G note[20]: G# note[21]: A note[22]: A# note[23]: B
*/
clkgen #(4) my_i2c_clk(clk,1'b0,1'b1,clk_bgm_vol);  //10k I2C clock  

always @ (posedge clk_bgm_vol)
begin
	if(kbdata == 61 && volume < 127)
	begin
		volume <= volume + 1;
        reset <= 1;
	end
	else if(kbdata == 45 && volume > 0)
	begin
		volume <= volume - 1;
        reset <= 1;
	end
	else begin
		volume <= volume;
        reset <= 0;
	end
end



always @ (posedge clk)
begin
if(en)
begin
    if(clk_bgm_cnt <= speedmax)
    begin
        clk_bgm_cnt <= clk_bgm_cnt + 1;
        freq <= freq;
    end
    else begin
        case (cnt)
           0: freq <= note[9];
            1: freq <= 0;
            2: freq <= 0;
            3: freq <= note[9];
            4: freq <= 0;
            5: freq <= 0;
            6: freq <= note[12];
            7: freq <= 0;
            8: freq <= note[14];
            9: freq <= 0;
            10: freq <= note[9];
            11: freq <= 0;
            12: freq <= 0;
            13: freq <= note[9];
            14: freq <= 0;
            15: freq <= 0;
            16: freq <= note[7];
            17: freq <= 0;
            18: freq <= note[8];
            19: freq <= 0;
            20: freq <= note[9];
            21: freq <= 0;
            22: freq <= 0;
            23: freq <= note[9];
            24: freq <= 0;
            25: freq <= 0;
            26: freq <= note[12];
            27: freq <= 0;
            28: freq <= note[14];
            29: freq <= 0;
            30: freq <= note[9];
            31: freq <= 0;
            32: freq <= 0;
            33: freq <= note[9];
            34: freq <= 0;
            35: freq <= 0;
            36: freq <= note[7];
            37: freq <= 0;
            38: freq <= note[8];
            39: freq <= 0;
/*
low
note[0]: C note[1]: C# note[2]: D note[3]: D# note[4]: E note[5]: F
note[6]: F# note[7]: G note[8]: G# note[9]: A note[10]: A# note[11]: B

mid
note[12]: C note[13]: C# note[14]: D note[15]: D# note[16]: E note[17]: F
note[18]: F# note[19]: G note[20]: G# note[21]: A note[22]: A# note[23]: B
*/
            40: freq <= note[21];
            41: freq <= 0;
            42: freq <= 0;
            43: freq <= note[21];
            44: freq <= 0;
            45: freq <= 0;
            46: freq <= 16'h0416;
            47: freq <= 0;
            48: freq <= 16'h0496;
            49: freq <= 0;
            50: freq <= note[21];
            51: freq <= 0;
            52: freq <= 0;
            53: freq <= note[21];
            54: freq <= 0;
            55: freq <= 0;
            56: freq <= note[19];
            57: freq <= 0;
            58: freq <= note[20];
            59: freq <= 0;
            60: freq <= note[21];
            61: freq <= 0;
            62: freq <= 0;
            63: freq <= note[21];
            64: freq <= 0;
            65: freq <= 0;
            66: freq <= 16'h0416;
            67: freq <= 0;
            68: freq <= 16'h0496;
            69: freq <= 0;
            70: freq <= note[21];
            71: freq <= 0;
            72: freq <= 0;
            73: freq <= note[21];
            74: freq <= 0;
            75: freq <= 0;
            76: freq <= note[19];
            77: freq <= 0;
            78: freq <= note[20];
            79: freq <= 0;
            80: freq <= note[21];
            81: freq <= note[21];
            82: freq <= note[21];
            83: freq <= note[21];
            default: freq <= 0;
        endcase
        if(cnt >= 87)
		begin
			cnt <= 0;
            clk_bgm_cnt <= 0;
		end
		else begin
			cnt <= cnt + 1;
            clk_bgm_cnt <= 0;
		end
    end
end
else begin
    cnt <= 0;
    clk_bgm_cnt <= 0;
    freq <= 0;
end
end

always @ (posedge clk)
begin
    case(level)
    1: speedmax <= 10000000;
    2: speedmax <= 8000000;
    3: speedmax <= 6250000;
    4: speedmax <= 5000000;
    default: speedmax <= 10000000;
    endcase
end 


// always @ (posedge clk)
// begin
//     if (en) begin
//         if(clk_bgm_cnt >= speedmax)
//         begin
//             case (cnt)
//             0: freq <= note[7]; 
//             1: freq <= note[14];
//             2: freq <= note[13];
//             3: freq <= note[7];
//             4: freq <= note[12];
//             5: freq <= note[11];
//             6: freq <= 0;
//             7: freq <= note[6];
//             8: freq <= note[5];
//             9: freq <= note[4];
//             10: freq <= note[6];
//             11: freq <= note[5];
//             12: freq <= note[4];
//             13: freq <= 0;
//             default: freq <= 0;
//             endcase
//             if(cnt >= 13)
// 		    begin
// 				cnt <= 0;
//                 clk_bgm_cnt <= 0;
// 		    end
// 		    else begin
// 				cnt <= cnt + 1;
//                 clk_bgm_cnt <= 0;
// 		    end
//         end
//         else begin
//             clk_bgm_cnt <= clk_bgm_cnt + 1;
//         end
//     end
//     else begin
//         cnt <= 0;
//     end
// end


endmodule 