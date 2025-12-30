module shift_reg (q_out, clk, rst_n, shift_en, dir, d_in);
parameter N = 15; //16 bit
output logic [N:0] q_out;
input logic clk, rst_n;
input logic shift_en;
input logic dir; //left 0 and right 1
input logic d_in;
integer i;
always_ff @(posedge clk) begin
if (!rst_n) begin
q_out <= 0; //reset
end
else if (shift_en) begin
if (dir == 1'b0) begin
for (i = N; i>0; i = i-1)
q_out[i] <= q_out[i-1];
q_out[0] <= d_in; //left
end
else begin
for (i = 0; i<N; i = i+1)
q_out[i] <= q_out[i+1];
q_out[N] <= d_in; //right
end
end
else
q_out <= q_out; //hold
end
endmodule