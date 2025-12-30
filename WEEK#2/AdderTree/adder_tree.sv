module adder_tree (P,EA,EB,dataA,dataB,clk);
parameter M = 8 , N = 16;
output logic [N-1:0] P;
input logic clk, EA, EB; 
input logic [M-1:0] dataA, dataB;

logic [M-1:0] A, B; 
logic [N-1:0] multiplier; 
logic [3:0]  count;      // log2(15) = 3.9 ~= 4

always_ff @(posedge clk) begin
if (EA) A <= dataA;
if (EB) B <= dataB;
end
always_ff @(posedge clk) begin
if (EA || EB) begin
multiplier <= 0;
count <= 0;
end
else if (count < M) begin
if (B[count])
multiplier <= multiplier + (A << count);
count <= count + 1;
end
end
always_ff @(posedge clk) begin
if (count == M)
P <= multiplier;
end

endmodule
