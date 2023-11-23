`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

// -- XTEA (ENC) --
// 089975E9
// 2555F334
// CE76E4F2
// 4D932AB3
// XTEA (ENC): OK
// -- XTEA (DEC) --
// A5A5A5A5
// 01234567
// FEDCBA98
// 5A5A5A5A

module tb;
    reg start, enc_dec, reset, clock;
    reg [127:0] data_in, key_in;
    wire [127:0] data_out;
    wire busy, ready;

    localparam PERIOD_100MHZ = 10;  

    initial
    begin
        clock = 1'b1;
        forever #(PERIOD_100MHZ/2) clock = ~clock;
    end

    initial
    begin
        reset = 1'b1;
        start = 1'b0;
        enc_dec = 1'b1;
        data_in = 128'h0;
        key_in = 128'h0;
        #30;
        reset = 0;
        key_in = 128'hDEADBEEF0123456789ABCDEFDEADBEEF;
        data_in = 128'hA5A5A5A501234567FEDCBA985A5A5A5A;
        enc_dec = 1;
        #30;
        start = 1;
        #50;
        start = 0;
        #800;
        reset = 1'b1;
        data_in = 128'h8926F8FD05A9F719B5F06B68074AC776;
        enc_dec = 0;
        #30;
        reset = 0;
        #30;
        start = 1;
        #800;
    end

    main DUT (
        .start(start),
        .enc_dec(enc_dec),
        .reset(reset),
        .clock(clock),
        .data_in(data_in),
        .key_in(key_in),
        .data_out(data_out),
        .busy(busy),
        .ready(ready)
    );

endmodule