// PIPELINED
// Fourth pipeline register: MEM_WB
// Total size (in bits): 64

module mem_wb (haveInstrIn, haveInstrOut, clk, reset, readDataIn, ALUOutIn, regFromMuxIn, WBIn,
    readDataOut, ALUOutOut, regFromMuxOut, regWrite, memToReg);

    // Input wires;
    input clk, reset, haveInstrIn;
    input [31:0] readDataIn, ALUOutIn;
    input [4:0] regFromMuxIn;
    input [1:0] WBIn;

    // Output regs;
    output reg [31:0] readDataOut, ALUOutOut;
    output reg [4:0] regFromMuxOut;
    output reg regWrite, memToReg;
    output reg haveInstrOut;

    // Copying data from the entries to the module's output registers when negedge is happening;
    always @(negedge clk) begin
        if (reset) begin
            readDataOut <= 32'b0;
            ALUOutOut <= 32'b0;
            regFromMuxOut <= 5'b0;
            regWrite <= 1'b0;
            memToReg <= 1'b0;
            haveInstrOut <= 1'b0;
        end
        else begin
            if (haveInstrIn) begin
                haveInstrOut <= 1'b1;
            end
            else begin
                haveInstrOut <= 1'b0;
            end
            readDataOut <= readDataIn;
            ALUOutOut <= ALUOutIn;
            regFromMuxOut <= regFromMuxIn;
            regWrite <= WBIn[1];
            memToReg <= WBIn[0];
        end
    end
endmodule
