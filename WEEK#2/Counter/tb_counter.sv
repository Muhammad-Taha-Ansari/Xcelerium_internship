`timescale 1ns/1ps

module tb_counter;

logic clk;
logic rst_n;
logic en;
logic up_dn;
logic [31:0] count;

integer i;
integer pass_count = 0;
integer fail_count = 0;
logic [31:0] expected;

counter dut (.count(count),.up_dn(up_dn),.en(en),.clk(clk),.rst_n(rst_n));

initial clk = 0;
always #5 clk = ~clk;

initial begin
rst_n = 0; en = 0; up_dn = 1; expected = 0; #10 rst_n = 1;

$display("------ STARTING DIRECTED TEST ------");

if (count !== 0) begin
$display("FAIL: RESET FAILED, count = %0d", count);
fail_count++;
end else pass_count++;

en = 1; up_dn = 1;
for (i = 0; i < 5; i++) begin
#10; expected = expected + 1; if (count !== expected) begin
$display("FAIL: UP mismatch at %0d: got=%0d exp=%0d", i, count, expected);
fail_count++;
end else pass_count++;
end

up_dn = 0;
for (i = 0; i < 3; i++) begin
#10;
expected = expected - 1; if (count !== expected) begin
$display("FAIL: DOWN mismatch at %0d: got=%0d exp=%0d", i, count, expected);
fail_count++;
end else pass_count++;
end

en = 0;
#10;
if (count !== expected) begin
$display("FAIL: HOLD mismatch: got=%0d exp=%0d", count, expected);
fail_count++;
end else pass_count++;

$display("------ STARTING RANDOM TEST ------");
for (i = 0; i < 10; i++) begin
en = $urandom_range(0,1);
up_dn = $urandom_range(0,1);
#10;

if (en && up_dn)
expected = expected + 1;
else if (en && !up_dn)
expected = expected - 1;

if (count !== expected) begin
$display("FAIL: RAND %0d got=%0d exp=%0d en=%0b up_dn=%0b", i, count, expected, en, up_dn);
fail_count++;
end else pass_count++;
end

// Summary
$display("------ TEST COMPLETE ------");
$display("PASSED = %0d, FAILED = %0d", pass_count, fail_count);
$finish;
end

endmodule