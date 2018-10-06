// PIPELINED
// Second pipeline register: ID_EX
// Total size (in bits): 128

module id_ex (haveInstrIn, haveInstrOut, clk, reset, pcIn, readData1In, readData2In, signExtendIn, rsIn, rtIn, rdIn, WBIn, MEMIn, EXIn,
    pcOut, readData1Out, readData2Out, signExtendOut, rsOut, rtOut, rdOut, WBOut, MEMOut, regDstOut, ALUOpOut, ALUSrcOut);

    // Input wires;
    input clk, reset, haveInstrIn;
    input [31:0] pcIn, readData1In, readData2In, signExtendIn;
    input [4:0] rsIn, rtIn, rdIn;
    input [1:0] WBIn;
    input [2:0] MEMIn;
    input [3:0] EXIn;

    // Output regs;
    output reg [31:0] pcOut, readData1Out, readData2Out, signExtendOut;
    output reg [4:0] rsOut, rtOut, rdOut;
    output reg [1:0] WBOut;
    output reg [2:0] MEMOut;
    output reg regDstOut;
    output reg [1:0] ALUOpOut;
    output reg ALUSrcOut;
    output reg haveInstrOut;

    // Copying data from the entries to the module's output registers when negedge is happening;
    always @(negedge clk) begin
        if (reset) begin
            pcOut <= 32'b0;
            readData1Out <= 32'b0;
            readData2Out <= 32'b0;
            signExtendOut <= 32'b0;
            rsOut <= 5'b0;
            rtOut <= 5'b0;
            rdOut <= 5'b0;
            WBOut <= 2'b0;
            MEMOut <= 3'b0;
            regDstOut <= 0;
            ALUOpOut <= 2'b0;
            ALUSrcOut <= 0;
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
            readData1Out <= readData1In;
            readData2Out <= readData2In;
            signExtendOut <= signExtendIn;
            rsOut <= rsIn;
            rtOut <= rtIn;
            rdOut <= rdIn;
            WBOut <= WBIn;
            MEMOut <= MEMIn;
            regDstOut <= EXIn[3];
            ALUOpOut <= {EXIn[2], EXIn[1]};
            ALUSrcOut <= EXIn[0];
        end
    end
endmodule
