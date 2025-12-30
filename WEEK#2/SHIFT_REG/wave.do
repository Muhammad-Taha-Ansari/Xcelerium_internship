onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clk /tb_shift_reg/clk
add wave -noupdate -color {light green} -label rst_n /tb_shift_reg/rst_n
add wave -noupdate -color {light blue} -label shift_en /tb_shift_reg/shift_en
add wave -noupdate -color pink -label dir /tb_shift_reg/dir
add wave -noupdate -color white -label d_in /tb_shift_reg/d_in
add wave -noupdate -color orange -label q_out -expand -subitemconfig {{/tb_shift_reg/q_out[15]} {-color orange} {/tb_shift_reg/q_out[14]} {-color orange} {/tb_shift_reg/q_out[13]} {-color orange} {/tb_shift_reg/q_out[12]} {-color orange} {/tb_shift_reg/q_out[11]} {-color orange} {/tb_shift_reg/q_out[10]} {-color orange} {/tb_shift_reg/q_out[9]} {-color orange} {/tb_shift_reg/q_out[8]} {-color orange} {/tb_shift_reg/q_out[7]} {-color orange} {/tb_shift_reg/q_out[6]} {-color orange} {/tb_shift_reg/q_out[5]} {-color orange} {/tb_shift_reg/q_out[4]} {-color orange} {/tb_shift_reg/q_out[3]} {-color orange} {/tb_shift_reg/q_out[2]} {-color orange} {/tb_shift_reg/q_out[1]} {-color orange} {/tb_shift_reg/q_out[0]} {-color orange}} /tb_shift_reg/q_out
add wave -noupdate -color red -label i /tb_shift_reg/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {249574 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {256 ns}
