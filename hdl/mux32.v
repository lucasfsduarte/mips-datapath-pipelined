// Módulo que implementa um Multiplexador com entradas de 32 bits de tamanho;

module mux32 (mux32In1, mux32In2, op_mux32, mux32Out);

    // Entradas do multiplexador de 32 bits;
	input [31:0] mux32In1, mux32In2;

    // Operação a ser executada no multiplexador;
	input op_mux32;

    // Saída do multiplexador;
	output reg [31:0] mux32Out;

    // Escolhe a saída do multiplexador toda vez que um dos sinais estiverem altos;
	always@ (*) begin
		case (op_mux32)
		      1'b0:
                mux32Out <= mux32In1;
              1'b1:
                mux32Out <= mux32In2;
		endcase
	end

endmodule
