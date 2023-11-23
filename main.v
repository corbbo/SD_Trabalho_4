/**
 * @module main
 * @brief Top-level module for encryption and decryption.
 *
 * This module implements a top-level interface for encryption and decryption operations.
 * It receives input data and a key, and outputs the encrypted or decrypted data.
 * The module controls the operation of the encoder and decoder modules based on the input signals.
 *
 * @param start Input signal indicating the start of the encryption or decryption process.
 * @param enc_dec Input signal indicating whether encryption or decryption should be performed.
 * @param reset Input signal for resetting the module.
 * @param clock Input clock signal.
 * @param data_in Input data to be encrypted or decrypted.
 * @param key_in Input key for encryption or decryption.
 * @param data_out Output encrypted or decrypted data.
 * @param busy Output signal indicating whether the module is busy performing encryption or decryption.
 * @param ready Output signal indicating whether the encryption or decryption operation is ready for the next input.
 */
module main (
    input start, enc_dec, reset, clock,
    input [127:0] data_in, key_in,
    output [127:0] data_out,
    output busy, ready
);

// FSM params
localparam STATE_IDLE = 2'b00;
localparam STATE_ENC = 2'b01;
localparam STATE_DEC = 2'b10;

// declare vars
wire start_rising, reset_rising, enc_ready, dec_ready;
reg enc_en, dec_en, enc_done, dec_done;
wire [127:0] enc_out, dec_out;
reg [1:0] EA;
assign data_out = enc_dec ? enc_out : dec_out;
assign busy = enc_en | dec_en;
assign ready = ~busy;

// instantiate modules
encoder encoder (
    .enable(enc_en),
    .clock(clock),
    .reset(reset_rising),
    .data_in(data_in),
    .key_in(key_in),
    .data_out(enc_out),
    .done(enc_ready)
);
decoder decoder (
    .enable(dec_en),
    .clock(clock),
    .reset(reset_rising),
    .data_in(data_in),
    .key_in(key_in),
    .data_out(dec_out),
    .done(dec_ready)
);
edge_detector start_edge_detector (
    .clock(clock),
    .reset(reset),
    .din(start),
    .rising(start_rising)
);
edge_detector reset_edge_detector (
    .clock(clock),
    .reset(reset),
    .din(reset),
    .rising(reset_rising)
);

// FSM
always @(posedge clock or posedge reset) begin
    if (reset) begin
        EA <= STATE_IDLE;
    end else begin
        case (EA)
            STATE_IDLE: begin
                if (start_rising) begin
                    EA <= enc_dec ? STATE_ENC : STATE_DEC;
                end else begin
                    EA <= STATE_IDLE;
                end
            end
            STATE_ENC: begin
                if (enc_ready) begin
                    EA <= STATE_IDLE;
                end else begin
                    EA <= STATE_ENC;
                end
            end
            STATE_DEC: begin
                if (dec_ready) begin
                    EA <= STATE_IDLE;
                end else begin
                    EA <= STATE_DEC;
                end
            end
            default begin
                EA <= STATE_IDLE;
            end
        endcase
    end
end

// state logic
always @(*) begin
    case (EA)
        STATE_IDLE: begin
            enc_en <= 0;
            dec_en <= 0;
        end
        STATE_ENC: begin
            enc_en <= 1;
        end
        STATE_DEC: begin
            dec_en <= 1;
        end
        default: begin
            enc_en <= 0;
            dec_en <= 0;
        end
    endcase
end

endmodule