module decoder (
    input enable, clock, reset,
    input [127:0] data_in, key_in,
    output [127:0] data_out,
    output reg done
);

// var declaration
reg [127:0] data_out_reg;
wire [31:0] key_segment;
reg [31:0] y0, z0, y1, z1, delta, sum;
reg [7:0] i;
reg flag, y_z_switch;
assign data_out = data_out_reg;

// key array instantiation
key_array key_array (
    .key_in(key_in),
    .sum(sum),
    .y_z_switch(y_z_switch),
    .key_segment(key_segment)
);

always @(posedge clock or posedge reset) begin
    if (reset) begin
        data_out_reg <= 0;
        done <= 0;
        y0 <= 0;
        z0 <= 0;
        y1 <= 0;
        z1 <= 0;
        i <= 0;
        delta <= 32'h9E3779B9;
        sum <= 32'hC6EF3720;
        flag <= 1;
        y_z_switch <= 0;
    end else if (enable) begin
        // If flag is set, load data_in into y0, z0, y1, z1, and clear flag
        if (flag) begin
            y0 <= data_in[31:0];
            z0 <= data_in[63:32];
            y1 <= data_in[95:64];
            z1 <= data_in[127:96];
            flag <= 0;
            done <= 0;
        end
        // if flag is not set, run the algorithm
        else if (i < 32) begin
            if (y_z_switch) begin // if y_z_switch is set, run the z algorithm, else run the y algorithm
                z1 <= z1 - (((y1 << 4) ^ (y1 >> 5) + y1)) ^ (sum + key_segment);
                z0 <= z0 - (((y0 << 4) ^ (y0 >> 5) + y0)) ^ (sum + key_segment);
                sum <= sum - delta;
                y_z_switch <= ~y_z_switch; // flip the switch to y algorithm
            end
            else begin
                y1 <= y1 - (((z1 << 4) ^ (z1 >> 5) + z1)) ^ (sum + key_segment);
                y0 <= y0 - (((z0 << 4) ^ (z0 >> 5) + z0)) ^ (sum + key_segment);
                y_z_switch <= ~y_z_switch; // flip switch back to z algorithm
                i <= i + 1;
            end
        end
        else begin
            data_out_reg[31:0] <= y0;
            data_out_reg[63:32] <= z0;
            data_out_reg[95:64] <= y1;
            data_out_reg[127:96] <= z1;
            done <= 1;
            flag <= 1;
            i <= 0;
        end
    end
end


endmodule