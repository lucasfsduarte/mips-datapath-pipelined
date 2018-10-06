module clock_gen (IN_CLOCK, OUT_CLOCK);

    input wire IN_CLOCK;
    output reg OUT_CLOCK = 0;

    reg [31:0] fraclock = 0;

    always @ (posedge IN_CLOCK) begin
    	fraclock <= fraclock + 1;
        if (fraclock == 50000000) begin
            fraclock <= 0;
            OUT_CLOCK <= ~OUT_CLOCK;
        end
    end
endmodule
