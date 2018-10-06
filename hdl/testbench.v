module testbench ();

// Registradores para gerar os sinais de entrada
reg clock;
reg reset = 1;

// Fios conectados nas saidas
wire [31:0] saida1, saida2, saida3;

// Instancia do modulo a ser simulado
mips_dpipelined dpipelined_0 (.clk(clock), .reset(reset), .out1(saida1), .out2(saida2), .out3(saida3));

initial begin
    // Arquivo com o resultado da simulacao
    $dumpfile("datapath.vcd");
    $dumpvars(0, testbench);

    // Exibe um monitor com os valores das variáveis e suas respectivas saídas
    $display("\n>> Caminho de dados para cada instrução\n");
    $display("\n>> Saída PC | Instrução | Saída ALU\n");
    $monitor(">> %b %b %b", saida1, saida2, saida3);
end

initial begin

    #5; reset = 1;
    #5; reset = 0;
    #5; clock = 1'b1;
    #5; clock = 1'b0;
    #5; clock = 1'b1;
    #5; clock = 1'b0;
    #5; clock = 1'b1;
    #5; clock = 1'b0;
    #5; clock = 1'b1;
    #5; clock = 1'b0;
    #5; clock = 1'b1;
    #5;  clock = 1'b0;
    #5;  clock = 1'b1;
    #5;  clock = 1'b0;
    #5;  clock = 1'b1;
    #5;  clock = 1'b0;
    #5;  clock = 1'b1;
    #5;  clock = 1'b0;
    #5;  clock = 1'b1;
    #5;  clock = 1'b0;
    #5;  clock = 1'b1;
    #5;  clock = 1'b0;
    #5;  clock = 1'b1;
    #5;  clock = 1'b0;
    #5;  clock = 1'b1;
    #5;  clock = 1'b0;
    #5;  clock = 1'b1;
    #5;  clock = 1'b0;
    #5;  clock = 1'b1;
    #5;  clock = 1'b0;
    #5;  clock = 1'b1;
    #5;  clock = 1'b0;
    #5;  clock = 1'b1;
    #5;  clock = 1'b0;
    #5;  clock = 1'b1;
    #5;  clock = 1'b0;
    #5;  clock = 1'b1;
    #5;  clock = 1'b0;
    #5;  clock = 1'b1;
    #5;  clock = 1'b0;
    #5;  clock = 1'b1;
    #5;  clock = 1'b0;
    #5;  clock = 1'b1;
    #5;  clock = 1'b0;
    #5;  clock = 1'b1;
    #5;  clock = 1'b0;

    $finish;
end

endmodule
