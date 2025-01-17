
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================
`include "..\hdl\main.v"
`include "..\fpga\clock_gen.v"
`include "..\fpga\display.v"

module mips_pipelined (

	//////////// CLOCK //////////
	CLOCK_50,
	CLOCK2_50,
	CLOCK3_50,

	//////////// LED //////////
	LEDG,
	LEDR,

	//////////// KEY //////////
	KEY,

	//////////// SW //////////
	SW,

	//////////// SEG7 //////////
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	HEX6,
	HEX7
);

//=======================================================
//  PARAMETER declarations
//=======================================================


//=======================================================
//  PORT declarations
//=======================================================

//////////// CLOCK //////////
input 		          		CLOCK_50;
input 		          		CLOCK2_50;
input 		          		CLOCK3_50;

//////////// LED //////////
output		     [8:0]		LEDG;
output		    [17:0]		LEDR;

//////////// KEY //////////
input 		     [3:0]		KEY;

//////////// SW //////////
input 		    [17:0]		SW;

//////////// SEG7 //////////
output		     [6:0]		HEX0;
output		     [6:0]		HEX1;
output		     [6:0]		HEX2;
output		     [6:0]		HEX3;
output		     [6:0]		HEX4;
output		     [6:0]		HEX5;
output		     [6:0]		HEX6;
output		     [6:0]		HEX7;


//=======================================================
//  REG/WIRE declarations
//=======================================================
wire [31:0] CURR_PIPELINE;
wire [31:0] CURR_ALU_OUT;
wire [31:0] CURR_INSTR;
wire [31:0] CURR_PC;
reg [31:0] CURR_INFO;
reg [31:0] INSTR_COUNTER;
wire [3:0] PIPE_LED;
wire CLOCK;


//=======================================================
//  Structural coding
//=======================================================

initial begin
	CURR_INFO = CURR_INSTR;
	INSTR_COUNTER = 32'b0;
end

clock_gen clock_gen_i0 (.IN_CLOCK(CLOCK_50), .OUT_CLOCK(CLOCK));
mips_dpipelined mips_dpipelined_i0 (.clk(CLOCK), .reset(SW[17]), .out1(CURR_PC), .out2(CURR_INSTR), .out3(CURR_ALU_OUT), .out4(PIPE_LED[3]), .out5(PIPE_LED[2]), .out6(PIPE_LED[1]), .out7(PIPE_LED[0]));
display display_i0 (CURR_INFO[31:28], HEX7);
display display_i1 (CURR_INFO[27:24], HEX6);
display display_i2 (CURR_INFO[23:20], HEX5);
display display_i3 (CURR_INFO[19:16], HEX4);
display display_i4 (CURR_INFO[15:12], HEX3);
display display_i5 (CURR_INFO[11:8], HEX2);
display display_i6 (CURR_INFO[7:4], HEX1);
display display_i7 (CURR_INFO[3:0], HEX0);

always @(posedge CLOCK) begin
	if (SW[17]) begin
		INSTR_COUNTER <= 32'b0;
	end
	else begin
		INSTR_COUNTER <= INSTR_COUNTER + 1;
	end
end

always @(*) begin
	if (SW[16]) begin
		CURR_INFO = CURR_PC;
	end
	else if (SW[15]) begin
		CURR_INFO = INSTR_COUNTER;
	end
	else begin
		CURR_INFO = CURR_INSTR;
	end
end

// Associação dos sinais do led
assign LEDG[0] = PIPE_LED[0];
assign LEDG[1] = PIPE_LED[1];
assign LEDG[2] = PIPE_LED[2];
assign LEDG[3] = PIPE_LED[3];

endmodule
