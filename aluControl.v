// Módulo que gera os sinais de controle da ALU.
// Código baseado na ALU implementada no apêndice C da referência [1].

module aluControl (aluOp, funcCode, aluCtrl, reset);

    input reset;
    input [1:0] aluOp;
    input [5:0] funcCode;
    output reg [3:0] aluCtrl;

    // Aplica o reset
    always @(reset) begin
        aluCtrl <= 4'b1111;
    end

    // Executa sempre que aluOp ou funcCode estiverem altos;
    always @(*) begin
        case (aluOp)
            2'b00:
                aluCtrl <= 4'b0010;
            2'b01:
                aluCtrl <= 4'b0110;
            2'b10:
                case(funcCode[3:0])
                    4'b0000: aluCtrl <= 4'b0010;
                    4'b0010: aluCtrl <= 4'b0110;
                    4'b0100: aluCtrl <= 4'b0000;
                    4'b0101: aluCtrl <= 4'b0001;
                    4'b1010: aluCtrl <= 4'b0111;
                    default: aluCtrl <= 4'b1111;
                endcase
            2'b11:
                case(funcCode[3:0])
                    4'b0010: aluCtrl <= 4'b0110;
                    4'b1010: aluCtrl <= 4'b0111;
                    default: aluCtrl <= 4'b1111;
                endcase
            default: aluCtrl <= 4'b1111;
        endcase
	end
endmodule
