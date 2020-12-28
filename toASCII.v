//This module receives scan code, and returns corresponding ASCII code.
module toASCII(
	input [7:0]data,
	output [7:0]asdata
);
(* ram_init_file = "ascii.mif" *)reg [7:0] toascii [255:0];

assign asdata = toascii[data];

//ROM
endmodule