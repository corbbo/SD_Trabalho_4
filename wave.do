onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider clock
add wave -noupdate /tb/clock
add wave -noupdate -divider buttons
add wave -noupdate /tb/reset
add wave -noupdate /tb/start
add wave -noupdate /tb/enc_dec
add wave -noupdate -divider input
add wave -noupdate -radix hexadecimal -radixshowbase 0 /tb/data_in
add wave -noupdate -radix hexadecimal -radixshowbase 0 /tb/key_in
add wave -noupdate -divider output
add wave -noupdate -radix hexadecimal -radixshowbase 0 /tb/data_out
add wave -noupdate -color {Medium Slate Blue} -label dec_out -radix hexadecimal -radixshowbase 0 /tb/DUT/dec_out
add wave -noupdate -color {Medium Slate Blue} -label enc_out -radix hexadecimal -radixshowbase 0 /tb/DUT/enc_out
add wave -noupdate /tb/ready
add wave -noupdate /tb/busy
add wave -noupdate -divider FSM
add wave -noupdate /tb/DUT/EA
add wave -noupdate -label enc_en /tb/DUT/enc_en
add wave -noupdate -label dec_en /tb/DUT/dec_en
add wave -noupdate -divider Encoder
add wave -noupdate -color Wheat -label i -radix decimal -radixshowbase 0 /tb/DUT/encoder/i
add wave -noupdate -color Wheat -label key_segment -radix hexadecimal -radixshowbase 0 /tb/DUT/encoder/key_segment
add wave -noupdate -label y0 -radix hexadecimal -radixshowbase 0 /tb/DUT/encoder/y0
add wave -noupdate -label y1 -radix hexadecimal -radixshowbase 0 /tb/DUT/encoder/y1
add wave -noupdate -color {Dark Green} -label sum -radix hexadecimal -radixshowbase 0 /tb/DUT/encoder/sum
add wave -noupdate -color White -label y_z_switch /tb/DUT/encoder/key_array/y_z_switch
add wave -noupdate -label z0 -radix hexadecimal -radixshowbase 0 /tb/DUT/encoder/z0
add wave -noupdate -label z1 -radix hexadecimal -radixshowbase 0 /tb/DUT/encoder/z1
add wave -noupdate -color {Dark Green} -label data_out_reg -radix hexadecimal -radixshowbase 0 /tb/DUT/encoder/data_out_reg
add wave -noupdate -divider Decoder
add wave -noupdate -color Wheat -label i -radix decimal -radixshowbase 0 /tb/DUT/decoder/i
add wave -noupdate -color {Sea Green} -label z1 -radix hexadecimal -radixshowbase 0 /tb/DUT/decoder/z1
add wave -noupdate -color {Sea Green} -label z0 -radix hexadecimal -radixshowbase 0 /tb/DUT/decoder/z0
add wave -noupdate -color {Dark Green} -label sum -radix hexadecimal -radixshowbase 0 /tb/DUT/decoder/sum
add wave -noupdate -color {Sea Green} -label y1 -radix hexadecimal -radixshowbase 0 /tb/DUT/decoder/y1
add wave -noupdate -color {Sea Green} -label y0 -radix hexadecimal -radixshowbase 0 /tb/DUT/decoder/y0
add wave -noupdate -color {Dark Green} -label data_out_reg -radix hexadecimal -radixshowbase 0 /tb/DUT/decoder/data_out_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {329 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 232
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {2520 ns}
