/**
 * @module key_array
 * @brief Module for selecting a segment of a key array based on input signals.
 *
 * This module takes a 128-bit key input and divides it into four 32-bit segments.
 * The selection of the segment is determined by the input signals 'sum' and 'y_z_switch'.
 * If 'y_z_switch' is low, the segment is selected based on the lower two bits of 'sum'.
 * If 'y_z_switch' is high, the segment is selected based on the upper two bits of 'sum' shifted right by 11 bits.
 * The selected segment is output as 'key_segment'.
 */

module key_array (
    input [127:0] key_in,           // Input key of 128 bits
    input [31:0] sum,               // Input sum of 32 bits
    input y_z_switch,               // Input switch signal
    output [31:0] key_segment       // Output selected key segment of 32 bits
);

wire [31:0] key_arr [0:3];          // Array of 32-bit wires to store key segments
wire [1:0] key_select;              // Wire to store the selected segment index

assign key_arr[0] = key_in[31:0]; // Assigns each segment of the key array
assign key_arr[1] = key_in[63:32];
assign key_arr[2] = key_in[95:64];
assign key_arr[3] = key_in[127:96];

assign key_select = ~y_z_switch ? sum & 3 : (sum >> 11) & 3; // Selects the segment index based on the input signals

assign key_segment = key_arr[key_select]; // Assigns the selected segment to the output

endmodule