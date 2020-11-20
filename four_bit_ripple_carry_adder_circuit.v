`timescale 1ns/1ns

module part2(SW, LEDR);
	input [9:0] SW; 
	output [9:0] LEDR; 
	wire [3:0] a; 
	wire [3:0] b;
	wire c_in; 
	wire s; 
	wire x,y,z; 
	
	assign a = SW[7:4];
	assign b = SW[3:0];
	assign c_in = SW[8];
		
	f_adder u0 (.A(a[0]), .B(b[0]), .Cin(c_in), .S(LEDR[0]), .Cout(x)); 
	f_adder u1 (.A(a[1]), .B(b[1]), .Cin(x), .S(LEDR[1]), .Cout(y)); 
	f_adder u2 (.A(a[2]), .B(b[2]), .Cin(y), .S(LEDR[2]), .Cout(z)); 
	f_adder u3 (.A(a[3]), .B(b[3]), .Cin(z), .S(LEDR[3]), .Cout(LEDR[9])); 
	
	assign LEDR[8:4] = 5'bx;
endmodule


module f_adder (A, B, Cin, S, Cout); 
	input A, B, Cin; 
	output S, Cout; 
	assign S = A^B^Cin;
	assign Cout = (A&B)|(A&Cin)|(B&Cin); 
endmodule

