// Módulo que simula uma memória e armazena as instruções que serão executadas pelo caminho de dados, segundo o PC;

module instructionMemory (address, instruction);

    input [31:0] address;
	output reg[31:0] instruction;

    // Array usado para armazenar as instruções provenientes do arquivo de instruções;
	reg [31:0] tempInstructions[0:8];

    // Lê as linhas do arquivo e as armazena no array, uma por uma;
	initial begin
		$readmemb("./files/instructions.bin", (tempInstructions));
	end

    // Recupera a instrução da vez e a retorna no parâmetro;
	always @(address) begin
		instruction = tempInstructions [address / 4];
	end
endmodule
