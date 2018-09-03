// Módulo responsável por somar 4 à um valor (especificamente o endereço armazenado em PC);

module add4 (pcIn, newPc);

    // ADD4: Incrementa 4 no valor atual do PC;
    input [31:0] pcIn;
    output reg [31:0] newPc;

    // Calcula PC + 4 toda vez que pcIn existir, independente do clock;
	always @(*) begin
		newPc = pcIn + 4'b0100;
	end

endmodule
