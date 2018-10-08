// PIPELINED
// Forwarding Unity

module forwarding_unity (reset, id_ex_rs, id_ex_rt, ex_mem_rd, mem_wb_rd, ex_mem_regWrite, mem_wb_regWrite, forwardA, forwardB);

    // Input wires;
    input reset;
    input [4:0] id_ex_rs; // ID/EX.RegisterRs;
    input [4:0] id_ex_rt; // MEM/WB.RegisterRt;
    input [4:0] ex_mem_rd; // EX/MEM.RegisterRd;
    input [4:0] mem_wb_rd; // MEM/WB.RegisterRd;
    input ex_mem_regWrite; // EX/MEM.RegWrite (WB[1]);
    input mem_wb_regWrite; // MEM/WB.RegWrite (WB(1));

    // Output regs;
    output reg [1:0] forwardA, forwardB;

    // Resolve hazards via forwarding:

    // Checking for hazards: EX Hazard
    always @ (*) begin
        if (reset) begin
            forwardA = 2'b0;
        end
        else begin
            if (ex_mem_regWrite && (ex_mem_rd != 0) && (ex_mem_rd == id_ex_rs))
                forwardA = 2'b10;

            else if (mem_wb_regWrite && (mem_wb_rd != 0) && !(ex_mem_regWrite && (ex_mem_rd != 0)) && (ex_mem_rd != id_ex_rs) && (mem_wb_rd == id_ex_rs))
                forwardA = 2'b01;

            else
                forwardA = 2'b00;
        end
    end

    // Checking for hazards: MEM Hazard
    always @ (*) begin
        if (reset) begin
            forwardB = 2'b0;
        end
        else begin
            if (ex_mem_regWrite && (ex_mem_rd != 0) && (ex_mem_rd == id_ex_rt))
                forwardB = 2'b10;

            else if (mem_wb_regWrite && (mem_wb_rd != 0) && !(ex_mem_regWrite && (ex_mem_rd != 0)) && (ex_mem_rd != id_ex_rt) && (mem_wb_rd == id_ex_rt))
                forwardB = 2'b01;

            else
                forwardB = 2'b00;
        end
    end
endmodule
