module BarrelShifter(data_out, data_in, shift_amt, dir);
input [31:0] data_in;
input [4:0] shift_amt;
input dir;
output [31:0] data_out;

wire [31:0] w_data_in;
wire [4:0] w_shift_amt;
wire w_dir;
reg [31:0] r_data_out;

assign w_data_in = data_in;
assign w_shift_amt = shift_amt;
assign w_dir = dir;
assign data_out = r_data_out;

always @(*) begin
if (w_dir == 0)
r_data_out = w_data_in << w_shift_amt;
else
r_data_out = w_data_in >> w_shift_amt;
end
endmodule
