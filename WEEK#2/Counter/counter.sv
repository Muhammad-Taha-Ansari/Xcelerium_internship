module counter (count, up_dn, en, clk, rst_n);
parameter N = 31;
output reg [N:0] count;
input clk;
input rst_n, en, up_dn;

always @(posedge clk) begin
if (!rst_n)
count <= 0;
else if (en && up_dn) //up
count <= count + 1;
else if (en && !up_dn) //down
count <= count - 1;
else
count <= count;   // hold
end

endmodule