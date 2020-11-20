module part3(input [9:0] SW, input [3:0] KEY, output reg [9:0] LEDR); 
	wire w0, w1, w2, w3, w4, w5, w6, w7, y;
	wire [7:0] rotate;
	assign rotate[0] = w0;
	assign rotate[1] = w1;
	assign rotate[2] = w2;
	assign rotate[3] = w3;
	assign rotate[4] = w4;
	assign rotate[5] = w5;
	assign rotate[6] = w6;
	assign rotate[7] = w7;
	assign y = (KEY[1]==1&KEY[2]==1&KEY[3]==1)?w0:w7;
	
	s_circuit s0(.left(w1), .right(w7), .loadleft(~KEY[2]), .d(SW[0]), .loadn(~KEY[1]), .clock(~KEY[0]), .q(w0), .RS(SW[9]));
	s_circuit s1(.left(w2), .right(w0), .loadleft(~KEY[2]), .d(SW[1]), .loadn(~KEY[1]), .clock(~KEY[0]), .q(w1), .RS(SW[9]));
	s_circuit s2(.left(w3), .right(w1), .loadleft(~KEY[2]), .d(SW[2]), .loadn(~KEY[1]), .clock(~KEY[0]), .q(w2), .RS(SW[9]));
	s_circuit s3(.left(w4), .right(w2), .loadleft(~KEY[2]), .d(SW[3]), .loadn(~KEY[1]), .clock(~KEY[0]), .q(w3), .RS(SW[9]));
	s_circuit s4(.left(w5), .right(w3), .loadleft(~KEY[2]), .d(SW[4]), .loadn(~KEY[1]), .clock(~KEY[0]), .q(w4), .RS(SW[9]));
	s_circuit s5(.left(w6), .right(w4), .loadleft(~KEY[2]), .d(SW[5]), .loadn(~KEY[1]), .clock(~KEY[0]), .q(w5), .RS(SW[9]));
	s_circuit s6(.left(w7), .right(w5), .loadleft(~KEY[2]), .d(SW[6]), .loadn(~KEY[1]), .clock(~KEY[0]), .q(w6), .RS(SW[9]));	
	s_circuit s7(.left(y), .right(w6), .loadleft(~KEY[2]), .d(SW[7]), .loadn(~KEY[1]), .clock(~KEY[0]), .q(w7), .RS(SW[9]));

	always @(*) 
	begin
		if(SW[9] == 1'b1)
			LEDR[7:0] <= 0;
		else
			LEDR[7:0] <= rotate[7:0];
	end
endmodule 


module mux2to1(x, y, s, m);
	input x,y,s;
	output m; 
	assign m = s ? y : x; 
endmodule 


module flipflop(D, clk, reset, Q);
	input D, clk, reset;
	output reg Q;
	
	always @(posedge clk)
	begin 
		if (reset == 1'b1)
			Q <= 0;
		else
			Q <= D;
	end 
endmodule 


module s_circuit(input left, input right, input loadleft, input wire d, input loadn, input clock, input RS, output wire q);
	wire d1, d2;
	mux2to1 outer(.x(right), .y(left), .s(loadleft), .m(d1));
	mux2to1 inner(.x(d), .y(d1), .s(loadn), .m(d2));
	flipflop flipper(.D(d2), .clk(clock), .reset(RS), .Q(q));
endmodule
