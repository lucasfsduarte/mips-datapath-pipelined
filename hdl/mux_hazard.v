// PIPELINED
// Mux Hazard Detection Unity
// Recieve ex, mem and wb and forward it based on control signal;

module mux_hazard (control, EXIn, MEMIn, WBIn, EXOut, MEMOut, WBOut);

    // Input wires;
    input control;
    input [3:0] EXIn;
    input [2:0] MEMIn;
    input [1:0] WBIn;

    // Output reg;
    output reg [3:0] EXOut;
    output reg [2:0] MEMOut;
    output reg [1:0] WBOut;

    // Setting the output based on control signal;
    always @ (*) begin
        case (control)
            1'b0: begin
                EXOut <= EXIn;
                MEMOut <= MEMIn;
                WBOut <= WBIn;
            end
            1'b1: begin
                EXOut <= 4'b0;
                MEMOut <= 3'b0;
                WBOut <= 2'b0;
            end
        endcase
    end
endmodule
