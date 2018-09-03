// Módulo responsável por enviar sinais importantes para outros componentes, como MUX, Memória de Dados, ULA e outros;

module control (opCode, EX, MEM, WB, if_flush, reset);

    input reset;
    input [5:0] opCode;
    output reg [3:0] EX;
    output reg [2:0] MEM;
    output reg [1:0] WB;
    output reg if_flush;

    // Registradores do módulo;
    reg regDest, branch, memRead, memToReg, memWrite, aluSrc, regWrite;
    reg [1:0] aluOp;

    // Aplica o reset;
    always @(reset) begin
        regDest <= 0; aluSrc <= 0; memToReg <= 0; regWrite <= 0; memRead <= 0; memWrite <= 0; branch <= 0;
        EX <= 4'b0; MEM <= 3'b0; WB <= 2'b0;
        aluOp <= 2'b00;
        if_flush <= 0;
    end

    // Bloco executado sempre que opCode estiver em estado alto;
    always @(*) begin

        case (opCode)

            // Em caso de instrução tipo R;
            6'b000000: begin
                regDest <= 1; aluSrc <= 0; memToReg <= 0; regWrite <= 1; memRead <= 0; memWrite <= 0; branch <= 0;
                aluOp <= 2'b10;
                if_flush <= 0;
            end

            // Em caso de instrução LW;
            6'b100011: begin
                regDest <= 0; aluSrc <= 1; memToReg <= 1; regWrite <= 1; memRead <= 1; memWrite <= 0; branch <= 0;
                aluOp <= 2'b00;
                if_flush <= 0;
            end

            // Em caso de instrução SW;
            6'b101011: begin
                regDest <= 0; aluSrc <= 1; memToReg <= 0; regWrite <= 0; memRead <= 0; memWrite <= 1; branch <= 0;
                aluOp <= 2'b00;
                if_flush <= 0;
            end

            // Em caso de uma instrução BEQ;
    		6'b000100: begin
    			regDest <= 0; aluSrc <= 0; memToReg <= 0; regWrite <= 0; memRead <= 0; memWrite <= 0; branch <= 1;
                aluOp <= 2'b01;
                if_flush <= 1;
    		end
        endcase

        // Atribuindo os valores dos controles aos fios de pipeline;
        EX[3] <= regDest;
        EX[2] <= aluOp[1];
        EX[1] <= aluOp[0];
        EX[0] <= aluSrc;
        MEM[2] <= branch;
        MEM[1] <= memRead;
        MEM[0] <= memWrite;
        WB[1] <= regWrite;
        WB[0] <= memToReg;
    end
endmodule
