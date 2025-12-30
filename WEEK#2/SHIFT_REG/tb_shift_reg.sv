`timescale 1ns/1ps

module tb_shift_reg;

parameter N = 15; 

logic [N:0] q_out;
logic clk, rst_n;
logic shift_en;
logic dir;      // 0 = left, 1 = right
logic d_in;

integer i;

shift_reg dut (.q_out(q_out),.clk(clk),.rst_n(rst_n),.shift_en(shift_en),.dir(dir),.d_in(d_in));

initial clk = 0;
always #5 clk = ~clk;

initial begin
rst_n = 0; shift_en = 0; dir = 0; d_in = 0; #10;
rst_n = 1;

shift_en = 1; dir = 0;
for (i = 0; i <= N; i = i + 1) begin
d_in = 1;
#10;
end

dir = 1;
for (i = 0; i <= N; i = i + 1) begin
d_in = 0;
#10;
end
shift_en = 0;
#20;

$finish;
end

initial begin
$monitor("T=%0t rst=%b en=%b dir=%b din=%b q=%d",
$time, rst_n, shift_en, dir, d_in, q_out);
end

endmodule
