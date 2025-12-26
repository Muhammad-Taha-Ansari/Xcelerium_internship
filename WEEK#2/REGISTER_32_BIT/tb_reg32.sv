`timescale 1ns/1ps

module tb_reg32 ();
wire [31:0] q;
reg [31:0] d;
reg clk;
reg rst_n;
reg load;

reg32 dut (q, d, clk, load, rst_n);

initial clk = 0;
always #5 clk = ~clk;

initial begin 
d = 0;
load = 0;
rst_n = 0;

@(posedge clk);
rst_n = 1;
@(posedge clk);
load = 1;
d = 32'd1;
@(posedge clk);
load = 0;
d = 32'd0;
@(posedge clk);
load = 1;
d = 32'd0;
@(posedge clk);
load = 0;
d = 32'd1;

@(posedge clk);
load = 0;

#20;
$finish;
end

assert property (@(posedge clk) !rst_n |-> q == 32'd0) else $error("Result Failed");
assert property (@(posedge clk) rst_n && load |-> q == $past(d)) else $error("Load Failed");
assert property (@(posedge clk) rst_n && !load |-> q == $past(q)) else $error("Hold Failed");

endmodule
