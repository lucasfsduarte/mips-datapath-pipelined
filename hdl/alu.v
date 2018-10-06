// Módulo que implementa uma ALU com AND, OR, NOR, adição, subtração, comparação ou saída nula.
// Código baseado na ALU implementada no apêndice C da referência [1].

module alu (A, B, aluCtrl, zero, aluOut, reset);

    input reset;
    input [31:0] A, B;
    input [3:0] aluCtrl;
    output reg [31:0] aluOut;
    output zero;

    // Associa nível alto à zero se a saída da ALU é verdadeira;
    assign zero = (aluOut == 0);

    always @(*) begin // Se aluCtrl, A ou B;

        // Aplica o reset;
        if (reset) begin
            aluOut <= 32'b0;
        end
        else begin
            // Operações existentes na ALU;
            case (aluCtrl)
                4'b0000: aluOut <= A & B; // Caso 0 - AND;
                4'b0001: aluOut <= A | B; // Caso 1 - OR;
                4'b0010: aluOut <= A + B; // Caso 2 - ADD;
                4'b0110: aluOut <= A - B; // Caso 6 - SUB;
                4'b0111: aluOut <= (A < B) ? 32'b1 : 32'b0; // Caso 7 - SLT;
                4'b1100: aluOut <= ~(A | B); // Caso 12 - NOR;
                default: aluOut <= 32'b0; // Default;
            endcase
        end
    end
endmodule
