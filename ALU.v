`timescale 1ns/1ns

module part3 (SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input [9:0] SW; 
	input [3:0] KEY; 
	output [9:0] LEDR; 
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	output [6:0] HEX3;
	output [6:0] HEX4;
	output [6:0] HEX5;
	wire [3:0] a; 
	wire [3:0] b;
	wire [2:0] in; 
	wire [4:0] out; 
	wire [7:0] c_0;
	wire x,y,z; 
	reg [7:0] ALUout;
	
	assign a = SW[7:4];
	assign b = SW[3:0];
	assign in = KEY[2:0];
	
	f_adder U0(.A(a[0]), .B(b[0]), .Cin(0), .S(out[0]), .Cout(x)); 
	f_adder U1(.A(a[1]), .B(b[1]), .Cin(x), .S(out[1]), .Cout(y)); 
	f_adder U2(.A(a[2]), .B(b[2]), .Cin(y), .S(out[2]), .Cout(z)); 
	f_adder U3(.A(a[3]), .B(b[3]), .Cin(z), .S(out[3]), .Cout(out[4])); 
	
	assign c_0 = {3'b000, out}; 
	always @(*)
	begin
		ALUout = 8'b00000000;
		case (in[2:0])
		3'b111: ALUout = c_0;
		3'b110: ALUout = a+b;
		3'b101: ALUout = {4'b0000, b};
		3'b100: 
					if ((a+b)!=0) begin
						ALUout = 8'b00000001;
					end
					
					else begin
						ALUout = 8'b00000000;
					end 	
					
		3'b011: 
					if ((a&b)!=0) begin
						ALUout = 8'b00000001;
					end
					else begin
						ALUout = 8'b00000000;
					end 
					
		3'b010: ALUout = {a,b};
		
		endcase
	end
	
	hex h0 (.SW(B), .HEX0(HEX0));
	hex h1 (.SW(4'b0000), .HEX0(HEX1));
	hex h2 (.SW(A), .HEX0(HEX2));
	hex h3 (.SW(4'b0000), .HEX0(HEX3));
	hex h4 (.SW(ALUout[3:0]), .HEX0(HEX4));
	hex h5 (.SW(ALUout[7:4]), .HEX0(HEX5));
	
	assign LEDR[0] = ALUout[0]; 
	assign LEDR[1] = ALUout[1]; 
	assign LEDR[2] = ALUout[2]; 
	assign LEDR[3] = ALUout[3]; 
	assign LEDR[4] = ALUout[4]; 
	assign LEDR[5] = ALUout[5]; 
	assign LEDR[6] = ALUout[6]; 
	assign LEDR[7] = ALUout[7]; 
endmodule



module f_adder (A, B, Cin, S, Cout); 
	input A, B, Cin; 
	output S, Cout; 
	assign S = A^B^Cin;
	assign Cout = (A&B)|(A&Cin)|(B&Cin); 
endmodule


module hex(SW, HEX0);
	input [9:0] SW;
	output [6:0] HEX0;
	assign HEX0[0] = (SW[0]&~SW[1]&~SW[2]&~SW[3])+(SW[2]&~SW[1]&~SW[0]&~SW[3])+(SW[0]&SW[1]&SW[3]&~SW[2])+(SW[0]&SW[2]&SW[3]&~SW[1]);
	assign HEX0[1] = (SW[0]&SW[2]&~SW[1]&~SW[3])+(SW[1]&SW[2]&~SW[0]&~SW[3])+(SW[0]&SW[1]&SW[3]&~SW[2])+(SW[2]&SW[3]&~SW[0]&~SW[1])+(SW[2]&SW[1]&SW[3]&~SW[0])+(SW[2]&SW[1]&SW[3]&SW[0]); 
	assign HEX0[2] = (SW[1]&~SW[0]&~SW[2]&~SW[3])+(SW[2]&SW[3]&~SW[0]&~SW[1])+(SW[2]&SW[1]&SW[3]&~SW[0])+(SW[2]&SW[1]&SW[3]&SW[0]);
	assign HEX0[3] = (SW[0]&~SW[1]&~SW[2]&~SW[3])+(SW[2]&~SW[1]&~SW[0]&~SW[3])+(SW[0]&SW[1]&SW[2]&~SW[3])+(SW[2]&SW[1]&SW[3]&SW[0])+(SW[0]&SW[3]&~SW[2]&~SW[1])+(SW[1]&SW[3]&~SW[0]&~SW[2]);
	assign HEX0[4] = (SW[0]&~SW[1]&~SW[2]&~SW[3])+(SW[2]&~SW[1]&~SW[0]&~SW[3])+(SW[0]&SW[1]&SW[2]&~SW[3])+(SW[0]&SW[1]&~SW[2]&~SW[3])+(SW[0]&SW[2]&~SW[1]&~SW[3])+(SW[0]&SW[3]&~SW[2]&~SW[1]);
	assign HEX0[5] = (SW[0]&~SW[1]&~SW[2]&~SW[3])+(SW[1]&~SW[0]&~SW[2]&~SW[3])+(SW[0]&SW[1]&~SW[2]&~SW[3])+(SW[0]&SW[1]&SW[2]&~SW[3])+(SW[0]&SW[3]&SW[2]&~SW[1]);
	assign HEX0[6] = (SW[0]&SW[1]&SW[2]&~SW[3])+(SW[0]&~SW[1]&~SW[2]&~SW[3])+(~SW[0]&~SW[1]&~SW[2]&~SW[3])+(SW[2]&~SW[1]&SW[3]&~SW[0]);
endmodule
