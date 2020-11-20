module part2(SW,KEY,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
	input [9:0] SW;
	input [3:0] KEY;
	output [9:0] LEDR;
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	output [6:0] HEX3;
	output [6:0] HEX4;
	output [6:0] HEX5; 	
	wire [4:0] w; 
	wire w1, w2, w3; 
	wire x1, x2, x3, x4, x5; 
	reg [7:0] d;
	reg [7:0] q;

	hex h0(.SW(SW[3:0]),.HEX0(HEX0)); 
	hex h1(.SW(0),.HEX0(HEX1)); 
	hex h2(.SW(0),.HEX0(HEX2)); 
	hex h3(.SW(0),.HEX0(HEX3)); 
	
	f_adder f1(.A(SW[0]),.B(q[0]),.Cin(0), .S(x1),.Cout(w1)); 
	f_adder f2(.A(SW[1]),.B(q[1]),.Cin(w1),.S(x2),.Cout(w2)); 
	f_adder f3(.A(SW[2]),.B(q[2]),.Cin(w2),.S(x3),.Cout(w3));
	f_adder f4(.A(SW[3]),.B(q[3]),.Cin(w3),.S(x4),.Cout(x5));

	assign w[4] = x5; 
	assign w[3] = x4;
	assign w[2] = x3;
	assign w[1] = x2;
	assign w[0] = x1;
	
	parameter p1 = 4'b0000; 
	parameter p2 = 3'b000; 
	parameter p3 = 4'b1111;
	
	always @(*) 
	begin 
		case(KEY[3:1])
			3'b111: d[7:0] = w[4:0]; 
			3'b110: d[7:0] = SW[3:0]+q[3:0]; 
			3'b101: d[7:0] = {p3,q[3:0]};
			3'b100: d[7:0] = {p1,(|SW[3:0])|(|q[3:0])}; 
			3'b011: d[7:0] = {p1,(&SW[3:0])&(&q[3:0])}; 
			3'b010: d[7:0] = (SW[3:0]<<q[3:0]); 
			3'b001: d[7:0] = (SW[3:0]*q[3:0]); 
			3'b000: d[7:0] = q[7:0];
			default: d[7:0] = 0; 
		endcase
	end 
	
	always @(posedge ~KEY[0])
	begin
		if (SW[9] == 1'b0)
			q[7:0] <= 8'b00000000;
		else 
			q[7:0] <= d[7:0];
	end 
	
	hex h4(.SW(q[3:0]),.HEX0(HEX4)); 
	hex h5(.SW(q[7:4]),.HEX0(HEX5)); 
	
	assign LEDR[7:0] = q[7:0]; 	
	
endmodule 


module f_adder (A,B,Cin,S,Cout); 
	input A, B, Cin; 
	output S,Cout; 
	assign S = A^B^Cin;
	assign Cout = (A&B)|(A&Cin)|(B&Cin); 
endmodule

module hex(SW, HEX0);
	input [9:0] SW;
	output [6:0] HEX0;
	assign HEX0[0] = (~SW[3]&~SW[2]&~SW[1]& SW[0])|(~SW[3]& SW[2]&~SW[1]&~SW[0])|( SW[3]&~SW[2]& SW[1]& SW[0])|( SW[3]& SW[2]&~SW[1]& SW[0]);
   assign HEX0[1] = (~SW[3]& SW[2]&~SW[1]& SW[0])|(~SW[3]& SW[2]& SW[1]&~SW[0])|( SW[3]&(SW[2]| SW[1]));
   assign HEX0[2] = (~SW[3]&~SW[2]& SW[1]&~SW[0])|( SW[3]& (SW[2]| SW[1]));
   assign HEX0[3] = (~SW[3]&~SW[2]&~SW[1]& SW[0])|(~SW[3]& SW[2]&~SW[1]&~SW[0])|(~SW[3]& SW[2]& SW[1]& SW[0])|( SW[3]&(SW[2]| SW[1]));
   assign HEX0[4] = (~SW[3]&~SW[2]&~SW[1]& SW[0])|(~SW[3]&~SW[2]& SW[1]& SW[0])|(~SW[3]& SW[2]&~SW[1]&~SW[0])|(~SW[3]& SW[2]&~SW[1]& SW[0])|(~SW[3]& SW[2]& SW[1]& SW[0])|(SW[3]&~SW[2]&~SW[1]& SW[0]);
   assign HEX0[5] = (~SW[3]&~SW[2]&~SW[1]& SW[0])|(~SW[3]&~SW[2]& SW[1]&~SW[0])|(~SW[3]&~SW[2]& SW[1]& SW[0])|(~SW[3]& SW[2]& SW[1]& SW[0])|( SW[0]& SW[3]& SW[2]&~SW[1]);
   assign HEX0[6] = (~SW[3]&~SW[2]&~SW[1]&~SW[0])|(~SW[3]&~SW[2]&~SW[1]& SW[0])|(~SW[3]& SW[2]& SW[1]& SW[0])|( SW[3]& SW[2]&~SW[1]&~SW[0]);
endmodule  
