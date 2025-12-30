module array_mul (P,EA,EB,dataA,dataB,clk);
parameter M = 8 , N = 16;
output logic [N-1:0] P;
input logic clk, EA, EB; 
input logic [M-1:0] dataA, dataB;
logic [M-1:0] A, B;
always_ff @(posedge clk) begin  
if (EA) A <= dataA; 
if (EB) B <= dataB;
P <= A * B;
end
endmodule



