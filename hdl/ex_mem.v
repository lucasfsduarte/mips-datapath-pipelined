// PIPELINED
// Third pipeline register: EX_MEM
// Total size (in bits): 97

module ex_mem (haveInstrIn, haveInstrOut, clk, reset, pcIn, zeroIn, ALUOutIn, readData2In, regFromMuxIn, WBIn, MEMIn,
    pcOut, zeroOut, ALUOutOut, readData2Out, regFromMuxOut, WBOut, branchOut, memReadOut, memWriteOut);

    // Input wires;
    input clk, reset, zeroIn, haveInstrIn;
    input [31:0] pcIn, ALUOutIn, readData2In;
    input [4:0] regFromMuxIn;
    input [1:0] WBIn;
    input [2:0] MEMIn;

    // Output regs;
    output reg [31:0] pcOut, ALUOutOut, readData2Out;
    output reg [4:0] regFromMuxOut;
    output reg [1:0] WBOut;
    output reg zeroOut, branchOut, memReadOut, memWriteOut;
    output reg haveInstrOut;

    // Copying data from the entries to the module's output registers when negedge is happening;
    always @(negedge clk) begin
        if (reset) begin
            pcOut <= 32'b0;
            zeroOut <= 1'b0;
            ALUOutOut <= 32'b0;
            readData2Out <= 32'b0;
            regFromMuxOut <= 5'b0;
            WBOut <= 2'b0;
            branchOut <= 1'b0;
            memReadOut <= 1'b0;
            memWriteOut <= 1'b0;
            haveInstrOut <= 1'b0;
        end
        else begin
            if (haveInstrIn) begin
                haveInstrOut <= 1'b1;
            end
            else begin
                haveInstrOut <= 1'b0;
            end
            pcOut <= pcIn;
            zeroOut <= zeroIn;
            ALUOutOut <= ALUOutIn;
            readData2Out <= readData2In;
            regFromMuxOut <= regFromMuxIn;
            WBOut <= WBIn;
            branchOut <= MEMIn[2];
            memReadOut <= MEMIn[1];
            memWriteOut <= MEMIn[0];
        end
    end
endmodule
