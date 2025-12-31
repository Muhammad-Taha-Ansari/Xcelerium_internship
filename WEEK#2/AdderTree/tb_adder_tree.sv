`timescale 1ns/1ps

module tb_adder_tree;

parameter M = 8, N = 16;

logic clk;
logic EA, EB;
logic [M-1:0] dataA, dataB;
logic [N-1:0] P;

logic [M-1:0] A_tb, B_tb;
logic [N-1:0] expected;

integer pass_count = 0;
integer fail_count = 0;
integer i;
//integer m = 4;

initial clk = 0;
always #5 clk = ~clk;

adder_tree #(M,N) dut (.P(P),.EA(EA),.EB(EB),.dataA(dataA),.dataB(dataB),.clk(clk));

//initial begin  //for GTK-WAVE
  //$dumpfile("adder_tree.vcd");   // VCD file name 
  //$dumpvars(0, tb_adder_tree);   // top module name
//end

initial begin
EA = 0; EB = 0; dataA = 0; dataB = 0; A_tb = 0; B_tb = 0; #10;

for (i = 0; i < 10; i = i + 1) begin
dataA = $urandom_range(0, 255);
dataB = $urandom_range(0, 255);

EA = 1; EB = 1;
@(posedge clk);
EA = 0; EB = 0;

A_tb = dataA; B_tb = dataB;

repeat (M) @(posedge clk); 
repeat (2) @(posedge clk); //miss se poochna hai

expected = A_tb * B_tb;

if (P === expected) begin
pass_count++;
$display("TEST %0d PASS : %0d * %0d = %0d", i, A_tb, B_tb, P);
end
else begin
fail_count++;
$error("TEST %0d FAIL : %0d * %0d = %0d (expected %0d)", i, A_tb, B_tb, P, expected);
end

#5;  
end

// Summary 
$display("\n------------------ SUMMARY ------------------");
$display("Total Tests  : %0d", pass_count + fail_count);
$display("Tests Passed : %0d", pass_count);
$display("Tests Failed : %0d", fail_count);
if (fail_count == 0)
$display("OVERALL STATUS : ALL TESTS PASSED");
else
$display("OVERALL STATUS : SOME TESTS FAILED");
$display("----------------------------------------------");

$finish;
end

endmodule
