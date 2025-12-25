`timescale 1ns/1ps

module tb_Adder32Bit();
reg [31:0] a, b;
reg cin;
wire [31:0] sum;
wire cout;

reg [31:0] expected_sum;
reg expected_cout;

integer i;
integer pass = 1;
integer fail = 0;

Adder32Bit dut(sum, cout, a, b, cin);

//GTKWave
initial begin
$dumpfile("Adder32Bit.vcd");
$dumpvars(0, tb_Adder32Bit);
end

task check;
begin
if ((sum === expected_sum) && (cout === expected_cout)) begin
$display("PASS: a=%0d b=%0d cin=%0b => sum=%0d cout=%0b", a, b, cin, sum, cout);
pass = pass + 1;
end else begin
$display("FAIL: a=%0d b=%0d cin=%0b => sum=%0d cout=%0b (expected sum=%0d cout=%0b)",
a, b, cin, sum, cout, expected_sum, expected_cout);
fail = fail + 1;
end
end
endtask

initial begin
$display("===== Adder32Bit Testbench Start =====");

a = 0; b = 0; cin = 0; #10;
expected_sum = a + b + cin;
expected_cout = 0;
check();

a = 1; b = 1; cin = 0; #10;
expected_sum = a + b + cin;
expected_cout = 0;
check();


a = 32'hFFFFFFFF; b = 1; cin = 0; #10;
{expected_cout, expected_sum} = a + b + cin;
check();

for (i = 0; i < 5; i = i + 1) begin
a = $urandom;
b = $urandom;
cin = $urandom % 2;
#10;
{expected_cout, expected_sum} = a + b + cin;
check();
end

a = 32'd15; b = 32'd2; cin = 0; #10;
expected_sum = a + b + 1;  
expected_cout = 0;
check();

a = 32'd7; b = 32'd3; cin = 1; #10;
expected_sum = 32'd0;       
expected_cout = 1;          
check();

//summary
$display("-----------Summary----------------");
$display("Total Passed: %0d", pass);
$display("Total Failed: %0d", fail);
$display("----------------------------------");

$finish;
end

endmodule

