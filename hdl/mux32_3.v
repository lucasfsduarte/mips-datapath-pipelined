// PIPELINED
// Mux with 3 inputs and 1 output (forwarding);

module mux32_3 (op, muxIn1, muxIn2, muxIn3, muxOut);

    // Input wires;
    input [1:0] op;
	input [31:0] muxIn1, muxIn2, muxIn3;

    // Output regs;
	output reg [31:0] muxOut;

    // Change the correspondent output;
	always@ (*) begin
		case (op)
            2'b00:
                muxOut = muxIn1;
            2'b10:
                muxOut = muxIn2;
            2'b01:
                muxOut = muxIn3;
		endcase
	end
endmodule
