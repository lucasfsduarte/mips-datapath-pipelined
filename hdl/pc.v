// Módulo que controla o endereço atual no PC;

module pc (pcIn, pcOut, clk, hzdWrite, reset);

	input [31:0] pcIn;
	output reg [31:0] pcOut;
    input clk, reset, hzdWrite;

    // Atualiza o valor armazenado em PC conforme a borda de subida do clock;
	always @(negedge clk) begin
		if (reset) begin
			pcOut <= 32'b0;
		end
		else begin
			if (hzdWrite) begin
				pcOut <= pcIn;
			end
		end
	end
    // A atualização acima só ocorre ao final de cada ciclo do clock;
endmodule
