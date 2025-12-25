`timescale 1ns/1ps
module tb_Encoder8_3();
reg [7:0] in;
wire [2:0] out;

reg [2:0] expected_out;

integer i;
integer pass = 1;
integer fail = 0;

Encoder8_3 dut(.in(in), .out(out));

//GTK WAVE
initial begin
$dumpfile("Encoder8_3.vcd");
$dumpvars(0, tb_Encoder8_3);
end
    
task check;
begin
if (out === expected_out) begin
$display("PASS: in=%b => out=%b", in, out);
pass = pass + 1;
end else begin
$display("FAIL: in=%b => out=%b (expected=%b)", in, out, expected_out);
fail = fail + 1;
end
end
endtask

initial begin
$display("===== Encoder8_3 Testbench Start =====");
//DIRECT TEST
in = 8'd1;  #10; expected_out = 3'd0; check();
in = 8'd2;  #10; expected_out = 3'd1; check();
in = 8'd4;  #10; expected_out = 3'd2; check();
in = 8'd8;  #10; expected_out = 3'd3; check();
in = 8'd16; #10; expected_out = 3'd4; check();
in = 8'd32; #10; expected_out = 3'd5; check();
in = 8'd64; #10; expected_out = 3'd6; check();
in = 8'd128;#10; expected_out = 3'd7; check();

//RANDOM TEST
for (i = 0; i < 10; i = i + 1) begin
in = $urandom % 256; #10;

if (in & 8'b00000001) expected_out = 3'b000;
else if (in & 8'b00000010) expected_out = 3'b001;
else if (in & 8'b00000100) expected_out = 3'b010;
else if (in & 8'b00001000) expected_out = 3'b011;
else if (in & 8'b00010000) expected_out = 3'b100;
else if (in & 8'b00100000) expected_out = 3'b101;
else if (in & 8'b01000000) expected_out = 3'b110;
else if (in & 8'b10000000) expected_out = 3'b111;
else expected_out = 3'b000;

check();
end

in = 8'b00001000; #10; expected_out = 3'b000;

check();

// Summary
$display("-------------SUMMARY--------------");
$display("Total Passed: %0d", pass);
$display("Total Failed: %0d", fail);
$display("----------------------------------");
$finish;
end
endmodule
