`timescale 1ns/1ns

module part1(SW,LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	wire [2:0] MuxSelect;
	
	assign MuxSelect = SW[9:7];
	
	reg Out;
	
	always @(*)
	begin
		Out=0;
		case(MuxSelect[2:0])
			3'b000: Out = SW[0];
			3'b001: Out = SW[1];
			3'b010: Out = SW[2];
			3'b011: Out = SW[3];
			3'b100: Out = SW[4];
			3'b101: Out = SW[5];
			3'b110: Out = SW[6];
		endcase	
	end
	
	assign LEDR[0] = Out;
 	
endmodule 
			
