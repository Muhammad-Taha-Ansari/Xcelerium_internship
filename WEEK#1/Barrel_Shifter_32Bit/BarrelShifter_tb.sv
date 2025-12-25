`timescale 1ns/1ps

module BarrelShifter_tb;
reg  [31:0] data_in;
reg  [4:0]  shift_amt;
reg         dir;

wire [31:0] data_out;

reg [31:0] expected;
integer i;
integer pass = 1;
integer fail = 0;

BarrelShifter dut (.data_out(data_out), .data_in(data_in), .shift_amt(shift_amt), .dir(dir));

task check;
begin
if (data_out === expected) begin
$display("PASS: data_in=%0d shift=%0d dir=%b out=%0d", data_in, shift_amt, dir, data_out);
pass = pass + 1;
end
else begin
$display("FAIL: data_in=%0d shift=%0d dir=%b out=%0d expected=%0d", data_in, shift_amt, dir, data_out, expected);
fail = fail + 1;
end
end
endtask

initial begin
        // GTKWave dump
$dumpfile("BarrelShifter.vcd");
$dumpvars(0, BarrelShifter_tb);

$display("_____Test Start_____");

// Directed Tests
data_in = 32'd1; shift_amt = 5'd2; dir = 0; #10; expected = data_in << shift_amt; check();

data_in = 32'd1; shift_amt = 5'd2; dir = 1; #10; expected = data_in >> shift_amt; check();

data_in = 32'd2; shift_amt = 5'd5; dir = 0; # 10; expected = data_in << shift_amt; check();

data_in = 32'd2; shift_amt = 5'd5; dir = 1; #10; expected = data_in >> shift_amt; check();

// Random Tests
for (i = 0; i < 10; i = i + 1) begin
data_in = $random;
shift_amt = $random % 32;
dir = $random % 2;
#10;

if (dir == 0)
expected = data_in << shift_amt;
else
expected = data_in >> shift_amt;

check();
end

// Summary
$display("-------------SUMMARY--------------");
$display("Total Passed: %0d", pass);
$display("Total Failed: %0d", fail);
$display("---------------------------");

$finish;
end

endmodule

