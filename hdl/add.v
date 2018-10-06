// Módulo responsável por somar dois valores quaisquer;

module add (addIn1, addIn2, addOut);

    // addIn1: Entrada do ADD;
    // addIn2: Entrada extend;

    input [31:0] addIn1, addIn2;
    output reg [31:0] addOut;

    // Operação ADD constante - independente do ciclo do clock;
    always @(*) begin
        addOut = addIn1 + addIn2;
    end

endmodule
