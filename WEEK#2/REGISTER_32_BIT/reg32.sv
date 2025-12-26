module reg32 (q, d, load, clk, rst_n);
parameter N = 32;
output logic [N-1:0] q;
input logic [N-1:0] d;
input logic clk; //sync clock -- active-low
input logic rst_n; //sync reset -- active-low
input logic load; //enable signal

always_ff @(posedge clk) 
begin
if (!rst_n)
q<=32'b0; //reset
else if (load)
q<=d; //yahan new data load hoga
else
q<=q; //yeh hold krke rakhe ga data
end

endmodule