`timescale 1ns / 1ns

module part2(SW,LEDR);
	input [9:0]SW;
	output [9:0]LEDR;
	wire a,b,c;
	
	v7404 u0(.pin1(SW[9]), .pin2(a));
	v7408 u1(.pin1(a), .pin2(SW[0]), .pin3(b), .pin4(SW[9]), .pin5(SW[1]), .pin6(c));
	v7432 u2(.pin1(b), .pin2(c), .pin3(LEDR[0]));
endmodule 


module v7404(pin1,pin3,pin5,pin9,pin11,pin13,pin2,pin4,pin6,pin8,pin10,pin12);
	input pin1,pin3,pin5,pin9,pin11,pin13;
	output pin2,pin4,pin6,pin8,pin10,pin12;
	assign pin2=~pin1;
	assign pin4=~pin3;
	assign pin6=~pin5;
	assign pin8=~pin9;
	assign pin10=~pin11;
	assign pin12=~pin13;
endmodule

module v7408(pin1,pin2,pin4,pin5,pin9,pin10,pin12,pin13,pin3,pin6,pin8,pin11);
	input pin1,pin2,pin4,pin5,pin9,pin10,pin12,pin13;
	output pin3,pin6,pin8,pin11;
	assign pin3=pin1&pin2;
	assign pin6=pin4&pin5;
	assign pin8=pin9&pin10;
	assign pin11=pin12&pin13;
endmodule

module v7432(pin1,pin2,pin4,pin5,pin9,pin10,pin12,pin13,pin3,pin6,pin8,pin11);
	input pin1,pin2,pin4,pin5,pin9,pin10,pin12,pin13;
	output pin3,pin6,pin8,pin11;
	assign pin3=pin1|pin2;
	assign pin6=pin4|pin5;
	assign pin8=pin9|pin10;
	assign pin11=pin12|pin13;
endmodule
