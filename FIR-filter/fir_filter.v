module fir_filter #(
    parameter DATA_WIDTH = 8,
    parameter COEFF0 = 8'd1,
    parameter COEFF1 = 8'd2,
    parameter COEFF2 = 8'd1
)(
    input clk,
    input resetn,
    input signed [DATA_WIDTH-1:0] x_in,
    output reg signed [DATA_WIDTH+3:0] y_out
);

    reg signed [DATA_WIDTH-1:0] x1, x2;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            x1 <= 0;
            x2 <= 0;
            y_out <= 0;
        end else begin
            x2 <= x1;
            x1 <= x_in;

            y_out <= (COEFF0 * x_in) + (COEFF1 * x1) + (COEFF2 * x2);
        end
    end

endmodule
