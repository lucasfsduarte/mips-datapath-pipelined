// PIPELINED
// First pipeline register: IF_ID
// Total size (in bits): 64

module if_id (clk, hzdWrite, reset, instructionIn, pcIn, instructionOut, pcOut, if_flush);

    // Input wires;
    input [31:0] pcIn, instructionIn;
    input clk, reset, hzdWrite, if_flush;

    // Output wires;
    output reg [31:0] pcOut, instructionOut;

    // Clearing module registers;
    always @(reset) begin
        pcOut <= 32'b0;
        instructionOut <= 32'b0;
    end

    // Proceed the pipeline when negedge happens.
    always @(negedge clk && hzdWrite) begin

        if (if_flush) begin
            instructionOut <= 32'b0;
            pcOut <= 32'b0;
        end
        else begin
            instructionOut <= instructionIn;
            pcOut <= pcIn;
        end
    end
endmodule
