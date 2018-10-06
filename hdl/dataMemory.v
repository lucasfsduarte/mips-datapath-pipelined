// Memória de dados que armazena os dados utilizados durante o percurso da instrução no caminho;

module dataMemory (clk, address, memWrite, memRead, writeData, readData, reset);

    input clk, memWrite, memRead, reset;
	input [31:0] address, writeData;
	output reg [31:0] readData;

    // Array de memória: 32 linhas de memória de 32 bits cada;
	reg [31:0] memory[0:31]; integer i;

    // Quando o clock estiver na borda de descida, escreve ou lê valores na/da memória conforme indicado;
	always @(negedge clk) begin
    // Aplica o reset
    // Inicializa todas as posições da memória com o valor 0;
        if (reset) begin
            for(i = 0; i <= 31; i = i + 1)
		          memory[i] <= 32'b0;
        end
        else begin
    		if (memWrite) begin
                memory[address] = writeData;
    		end

    		if (memRead) begin
    			readData = memory[address];
    		end
        end
	end
endmodule
