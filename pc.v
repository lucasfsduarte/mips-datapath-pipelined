// Módulo que controla o endereço atual no PC;

module pc (pcIn, pcOut, clk, hzdWrite, reset);

	input [31:0] pcIn;
	output reg [31:0] pcOut;
    input clk, reset, hzdWrite;

    // Inicializa o endereço armazenado em PC como sendo 0;
	always @(reset) begin
		pcOut <= 1'b0;
	end

    // Atualiza o valor armazenado em PC conforme a borda de subida do clock;
	always @(negedge clk && hzdWrite) begin

        pcOut <= pcIn;
	end
    // A atualização acima só ocorre ao final de cada ciclo do clock;
endmodule
