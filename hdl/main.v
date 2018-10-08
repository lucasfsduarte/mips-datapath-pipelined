`include "add.v"
`include "add4.v"
`include "alu.v"
`include "aluControl.v"
`include "control.v"
`include "dataMemory.v"
`include "ex_mem.v"
`include "forwarding.v"
`include "hazard_unit.v"
`include "id_ex.v"
`include "if_id.v"
`include "instructionMemory.v"
`include "logicAnd.v"
`include "mem_wb.v"
`include "mux_hazard.v"
`include "mux5.v"
`include "mux32_3.v"
`include "mux32.v"
`include "pc.v"
`include "registers.v"
`include "signExtend.v"
`include "sl2.v"

// Módulo responsável por interligar todos os outros módulos construídos individualmente, afim de formar o caminho de dados;

module mips_dpipelined (clk, reset, out1, out2, out3, out4, out5, out6, out7);

    input wire clk, reset;
    output reg [31:0] out1, out2, out3;
    output reg out4, out5, out6, out7;

    // Wires que serão utilizados para conectar os módulos;
    wire sin1, sin2, sin3, sin4;

    // PC
    wire [31:0] pcIn, pcOut;

    // Instruction Memory
    wire [31:0] instruction;

    // Registers
    wire [31:0] outRegA, outRegB;

    // Mux - Registers
    wire [4:0] outMuxRegisters;

    // Sign Extend
    wire [31:0] outSignExt;

    // Alu Control
    wire [3:0] outAluCtrl;

    // Alu
    wire [31:0] outAlu;
    wire zero;

    // Mux - Alu
    wire [31:0] outMuxAlu;

    // Data Memory
    wire [31:0] outDataMem;

    // Mux - Data Memory
    wire [31:0] outMuxDataMem;

    // Add 4
    wire [31:0] outAdd4;

    // Shift Left
    wire [31:0] signalSL;

    // Add
    wire [31:0] outAdd;

    // Wires do pipeline
    // IF_ID
    wire [31:0] if_id_instructionOut;
    wire [31:0] if_id_pcOut;

    // ID_EX
    wire [3:0] id_ex_EX;
    wire [2:0] id_ex_MEM;
    wire [1:0] id_ex_WB;

    // ID_EX
    wire [31:0] id_ex_pcOut;
    wire [31:0] id_ex_readData1Out;
    wire [31:0] id_ex_readData2Out;
    wire [31:0] id_ex_signExtendedOut;
    wire [4:0] id_ex_rsOut;
    wire [4:0] id_ex_rtOut;
    wire [4:0] id_ex_rdOut;
    wire [1:0] id_ex_WBOut;
    wire [2:0] id_ex_MEMOut;
    wire [1:0] id_ex_AluOpOut;
    wire id_ex_regDstOut;
    wire id_ex_AluSrcOut;

    // EX_MEM
    wire [31:0] ex_mem_pcOut;
    wire ex_mem_zeroOut;
    wire [31:0] ex_mem_aluOutOut;
    wire [31:0] ex_mem_readData2Out;
    wire [4:0] ex_mem_regFromMuxOut;
    wire [1:0] ex_mem_WBOut;
    wire ex_mem_branchOut, ex_mem_memReadOut, ex_mem_memWriteOut;

    // MEM_WB
    wire [31:0] mem_wb_readDataOut, mem_wb_aluOutOut;
    wire [4:0] mem_wb_regFromMuxOut;
    wire mem_wb_regWrite, mem_wb_memToReg;

    // Outros fios
    wire PCSrc, if_flush;
    wire [1:0] forwardA, forwardB;
    wire [31:0] muxForwardAOut, muxForwardBOut;
    wire hzdMuxControl, hzdPCWrite, hzdIFIDWrite;
    wire [3:0] hzdEXOut;
    wire [2:0] hzdMEMOut;
    wire [1:0] hzdWBOut;

    ////////////////////////////////////////////////////////////////////////////
    //   Módulos Default                                                      //
    ////////////////////////////////////////////////////////////////////////////

    pc pc_module (.pcIn(pcIn), .pcOut(pcOut), .clk(clk), .hzdWrite(hzdPCWrite), .reset(reset));

    instructionMemory instruction_memory_module (.address(pcOut), .instruction(instruction));

    control control_module (.opCode(if_id_instructionOut[31:26]), .EX(id_ex_EX), .MEM(id_ex_MEM), .WB(id_ex_WB), .if_flush(if_flush), .reset(reset));

    mux5 mux_reg_module (.mux5In1(id_ex_rtOut), .mux5In2(id_ex_rdOut), .op_mux5(id_ex_regDstOut), .mux5Out(outMuxRegisters));

    registers registers_module (.regA(if_id_instructionOut[25:21]), .regB(if_id_instructionOut[20:16]), .regWrite(mem_wb_regWrite), .writeRegister(mem_wb_regFromMuxOut), .writeData(outMuxDataMem), .clk(clk), .outA(outRegA), .outB(outRegB), .reset(reset));

    signExtend sign_extend_module (.signExIn(if_id_instructionOut[15:0]), .signExOut(outSignExt));

    mux32 mux_alu (.mux32In1(muxForwardBOut), .mux32In2(id_ex_signExtendedOut), .op_mux32(id_ex_AluSrcOut), .mux32Out(outMuxAlu));

    aluControl alu_control_module (.aluOp(id_ex_AluOpOut), .funcCode(id_ex_signExtendedOut[5:0]), .aluCtrl(outAluCtrl), .reset(reset));

    alu alu_module (.A(muxForwardAOut), .B(outMuxAlu), .aluCtrl(outAluCtrl), .zero(zero), .aluOut(outAlu), .reset(reset));

    dataMemory data_memory_module (.clk(clk), .address(ex_mem_aluOutOut), .memWrite(ex_mem_memWriteOut), .memRead(ex_mem_memReadOut), .writeData(ex_mem_readData2Out), .readData(outDataMem), .reset(reset));

    mux32 mux_data_memory_module (.mux32In1(mem_wb_aluOutOut), .mux32In2(mem_wb_readDataOut), .op_mux32(mem_wb_memToReg), .mux32Out(outMuxDataMem));

    add4 add4_module (.pcIn(pcOut), .newPc(outAdd4));

    sl2 shift_left_module (.slIn(id_ex_signExtendedOut), .slOut(signalSL));

    add add_module (.addIn1(id_ex_pcOut), .addIn2(signalSL), .addOut(outAdd));

    logicAnd and_module (.andIn1(ex_mem_branchOut), .andIn2(ex_mem_zeroOut), .andOut(PCSrc));

    mux32 muxAnd (.mux32In1(outAdd4), .mux32In2(ex_mem_pcOut), .op_mux32(PCSrc), .mux32Out(pcIn));

    ////////////////////////////////////////////////////////////////////////////
    //   Módulos Pipelined                                                    //
    ////////////////////////////////////////////////////////////////////////////

    if_id ifid (.haveInstrOut(sin1), .clk(clk), .hzdWrite(hzdIFIDWrite), .reset(reset), .instructionIn(instruction), .pcIn(outAdd4), .instructionOut(if_id_instructionOut), .pcOut(if_id_pcOut), .if_flush(if_flush));

    id_ex idex (.haveInstrIn(sin1), .haveInstrOut(sin2), .clk(clk), .reset(reset), .pcIn(if_id_pcOut), .readData1In(outRegA), .readData2In(outRegB), .signExtendIn(outSignExt), .rsIn(if_id_instructionOut[25:21]), .rtIn(if_id_instructionOut[20:16]), .rdIn(if_id_instructionOut[15:11]), .WBIn(hzdWBOut), .MEMIn(hzdMEMOut), .EXIn(hzdEXOut),
        .pcOut(id_ex_pcOut), .readData1Out(id_ex_readData1Out), .readData2Out(id_ex_readData2Out), .signExtendOut(id_ex_signExtendedOut), .rsOut(id_ex_rsOut), .rtOut(id_ex_rtOut), .rdOut(id_ex_rdOut), .WBOut(id_ex_WBOut), .MEMOut(id_ex_MEMOut), .regDstOut(id_ex_regDstOut), .ALUOpOut(id_ex_AluOpOut), .ALUSrcOut(id_ex_AluSrcOut));

    ex_mem exmem (.haveInstrIn(sin2), .haveInstrOut(sin3), .clk(clk), .reset(reset), .pcIn(outAdd), .zeroIn(zero), .ALUOutIn(outAlu), .readData2In(muxForwardBOut), .regFromMuxIn(outMuxRegisters), .WBIn(id_ex_WBOut), .MEMIn(id_ex_MEMOut),
        .pcOut(ex_mem_pcOut), .zeroOut(ex_mem_zeroOut), .ALUOutOut(ex_mem_aluOutOut), .readData2Out(ex_mem_readData2Out), .regFromMuxOut(ex_mem_regFromMuxOut), .WBOut(ex_mem_WBOut), .branchOut(ex_mem_branchOut), .memReadOut(ex_mem_memReadOut), .memWriteOut(ex_mem_memWriteOut));

    mem_wb memwb (.haveInstrIn(sin3), .haveInstrOut(sin4), .clk(clk), .reset(reset), .readDataIn(outDataMem), .ALUOutIn(ex_mem_aluOutOut), .regFromMuxIn(ex_mem_regFromMuxOut), .WBIn(ex_mem_WBOut),
        .readDataOut(mem_wb_readDataOut), .ALUOutOut(mem_wb_aluOutOut), .regFromMuxOut(mem_wb_regFromMuxOut), .regWrite(mem_wb_regWrite), .memToReg(mem_wb_memToReg));

    forwarding_unity forwarding (.reset(reset), .id_ex_rs(id_ex_rsOut), .id_ex_rt(id_ex_rtOut), .ex_mem_rd(ex_mem_regFromMuxOut), .mem_wb_rd(mem_wb_regFromMuxOut), .ex_mem_regWrite(ex_mem_WBOut[1]), .mem_wb_regWrite(mem_wb_regWrite), .forwardA(forwardA), .forwardB(forwardB));

    mux32_3 muxForwardingA (.op(forwardA), .muxIn1(id_ex_readData1Out), .muxIn2(ex_mem_aluOutOut), .muxIn3(outMuxDataMem), .muxOut(muxForwardAOut));

    mux32_3 muxForwardingB (.op(forwardB), .muxIn1(id_ex_readData2Out), .muxIn2(ex_mem_aluOutOut), .muxIn3(outMuxDataMem), .muxOut(muxForwardBOut));

    hazard_unit hazarding (.reset(reset), .id_ex_rt(id_ex_rtOut), .id_ex_memRead(id_ex_MEMOut[1]), .if_id_instruction(if_id_instructionOut), .mux_controller(hzdMuxControl), .pc_write(hzdPCWrite), .if_id_write(hzdIFIDWrite));

    mux_hazard muxHazard (.control(hzdMuxControl), .EXIn(id_ex_EX), .MEMIn(id_ex_MEM), .WBIn(id_ex_WB), .EXOut(hzdEXOut), .MEMOut(hzdMEMOut), .WBOut(hzdWBOut));

    ////////////////////////////////////////////////////////////////////////////
    //   Atribuição de sinais                                                 //
    ////////////////////////////////////////////////////////////////////////////

    always @ (instruction) begin
        out1 = pcOut/4;
        out2 = instruction;
        out3 = outAlu;
        out4 = sin1;
        out5 = sin2;
        out6 = sin3;
        out7 = sin4;
    end
endmodule
