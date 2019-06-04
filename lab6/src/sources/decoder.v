`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:04:55 05/29/2019 
// Design Name: 
// Module Name:    decoder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:33:28 11/22/2017 
// Design Name: 
// Module Name:    decoder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module decoder(
    input [3:0] hex,
    output reg [7:0] data
    );

	always @(*)
	 begin
	   case(hex)
			4'h0: data = 8'b0000_0011;
			4'h1: data = 8'b1001_1111;
			4'h2: data = 8'b0010_0101;
			4'h3: data = 8'b0000_1101;
			4'h4: data = 8'b1001_1001;
			4'h5: data = 8'b0100_1001;
			4'h6: data = 8'b0100_0001;
			4'h7: data = 8'b0001_1111;
			4'h8: data = 8'b0000_0001;
			4'h9: data = 8'b0000_1001;
			4'hA: data = 8'b0001_0001;
			4'hB: data = 8'b1100_0001;
			4'hC: data = 8'b0110_0011;
			4'hD: data = 8'b1000_0101;
			4'hE: data = 8'b0110_0001;
			4'hF: data = 8'b0111_0001;
			default: data = 8'b1111_1111;
		endcase
	end	

endmodule
