// Módulo responsável por realizar a operação de Shift para a esquerda 2 vezes em uma dada entrada;

module sl2 (slIn, slOut);

	input [31:0] slIn;
	output wire [31:0] slOut;

    // Declaração de um registrador temporário para receber o valor do shift left;
    // Isso é feito para que o valor original da entrada não seja alterado;
	reg [31:0] slAux;

    // Operação de Shift Left com 2;
	always @(*) begin
		slAux = slIn << 2;
	end

    // Associando o valor deslocado à saída;
	assign slOut = slAux;

endmodule
