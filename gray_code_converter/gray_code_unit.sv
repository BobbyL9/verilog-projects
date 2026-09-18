module gray_code_unit #(
    parameter int WIDTH = 4
) (
    input logic [WIDTH-1:0] binary_in,
    output logic [WIDTH-1:0] gray_out,

    input logic [WIDTH-1:0] gray_in,
    output logic [WIDTH-1:0] binary_out
);

// convert binary to gray code
assign gray_out = binary_in ^ (binary_in >> 1);

//convert gray to binary
always_comb begin
    binary_out[WIDTH-1] = gray_in[WIDTH-1];
    for (int i = WIDTH-2; i >= 0; i--) begin
        binary_out[i] = gray_in[i] ^ binary_out[i+1];
    end
end

endmodule