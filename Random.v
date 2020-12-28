module Random(
	input en,
	input rst_n,
	input srand,
	input clk,
	output reg[7:0] out_num
);

	reg [7:0] num;
	parameter seed=100;
	parameter min=0;
	parameter max=255;
	
	initial begin
		num=seed;
	end
	
	always@(posedge en or negedge rst_n or posedge srand)
	begin
		if(!rst_n)
			num<=0;
		else if(srand)
			num<=seed;
		else if(en)
		begin
			//num<={num[7],num[0],num[1],num[2],num[3]^num[7],num[4]^num[7],num[5]^num[7],num[6]};
			num<={num[4]^num[3]^num[2]^num[0],num[7:1]};
			out_num<=num%(max-min+1)+min;
		end	
	end
	
	

endmodule                                                                       