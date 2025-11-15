module tb();
    reg clk, resetn;
    reg signed [7:0] x_in;
    wire signed [11:0] y_out;

    fir_filter UUT (
        .clk(clk),
        .resetn(resetn),
        .x_in(x_in),
        .y_out(y_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        resetn = 0; x_in = 0;
        #10 resetn = 1;

        #10 x_in = 8'd10;
        #10 x_in = 8'd20;
        #10 x_in = 8'd30;
        #10 x_in = 8'd0;
        #50 $finish;
    end

    initial begin
        $monitor("Time=%0t x_in=%d y_out=%d", $time, x_in, y_out);
    end
endmodule
