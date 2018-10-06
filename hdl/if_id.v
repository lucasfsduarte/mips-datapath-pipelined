// PIPELINED
// First pipeline register: IF_ID
// Total size (in bits): 64

module if_id (haveInstrOut, clk, hzdWrite, reset, instructionIn, pcIn, instructionOut, pcOut, if_flush);

    // Input wires;
    input [31:0] pcIn, instructionIn;
    input clk, reset, hzdWrite, if_flush;

    // Output wires;
    output reg [31:0] pcOut, instructionOut;
    output reg haveInstrOut;

    // Proceed the pipeline when negedge happens.
    always @(negedge clk) begin
        if (reset) begin
            pcOut <= 32'b0;
            instructionOut <= 32'b0;
            haveInstrOut <= 1'b0;
        end
        else begin
            if (instructionIn) begin
                haveInstrOut <= 1'b1;
            end
            else begin
                haveInstrOut <= 1'b0;
            end
            if (hzdWrite) begin
                if (if_flush) begin
                    instructionOut <= 32'b0;
                    pcOut <= 32'b0;
                end
                else begin
                    instructionOut <= instructionIn;
                    pcOut <= pcIn;
                end
            end
        end
    end
endmodule
