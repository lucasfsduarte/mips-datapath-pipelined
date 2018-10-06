// Módulo responsável por extender uma entrada de 16 bits para 32 bits;

module signExtend (signExIn, signExOut);

    input [15:0] signExIn;
    output wire [31:0] signExOut;

    // Registrador auxiliar para receber a extensão (mantém o valor original intacto);
    reg [31:0] signAux;

    // Realiza a extensão, extendendo o bit mais significativo;
    always @(*) begin
        signAux = {{16{signExIn[15]}}, signExIn};
    end

    // Associa o signAux ao fio de saída, preservando o valor de entrada;
    assign signExOut = signAux;
endmodule
