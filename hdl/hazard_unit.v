// PIPELINED
// Hazard detection unity

module hazard_unit (reset, id_ex_rt, id_ex_memRead, if_id_instruction, mux_controller, pc_write, if_id_write);

    // Input wires;
    input reset;
    input id_ex_memRead; // ID/EX.MemRead;
    input [4:0] id_ex_rt; // ID/EX.RegisterRt;
    input [31:0] if_id_instruction;

    // Output regs;
    output reg mux_controller, pc_write, if_id_write;

    // Registers used in the pipeline
    // RS = if_id_instruction[25:21];
    // RT = if_id_instruction[20:16];
    // Stall the pipeline if a hazard is detected;
    always @ (*) begin
        if (reset) begin
            pc_write = 1'b0;
            if_id_write = 1'b0;
            mux_controller = 1'b1;
		  end
        else begin
            if (id_ex_memRead && ((id_ex_rt == if_id_instruction[25:21]) || (id_ex_rt == if_id_instruction[20:16]))) begin
                pc_write = 1'b0;
                if_id_write = 1'b0;
                mux_controller = 1'b1;
            end
            else begin
                pc_write = 1'b1;
                if_id_write = 1'b1;
                mux_controller = 1'b0;
            end
        end
    end
endmodule
