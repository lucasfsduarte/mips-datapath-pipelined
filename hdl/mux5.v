// Módulo que implementa um Multiplexador com entradas de 5 bits de tamanho;

module mux5 (mux5In1, mux5In2, op_mux5, mux5Out);

    // Entradas do multiplexador de 5 bits;
	input [4:0] mux5In1, mux5In2;

    // Operação a ser executada no multiplexador;
	input op_mux5;

    // Saída do multiplexador;
	output reg [4:0] mux5Out;

    // Escolhe a saída do multiplexador toda vez que um dos sinais estiverem altos;
	always@ (*) begin
		case (op_mux5)
		      1'b0:
                mux5Out <= mux5In1;
              1'b1:
                mux5Out <= mux5In2;
		endcase
	end

endmodule
