`timescale 1ns/1ps

module tb_gray_code_unit;

    localparam int WIDTH = 4;

    // Interface Signals
    logic [WIDTH-1:0] binary_in;
    logic [WIDTH-1:0] gray_out;
    
    logic [WIDTH-1:0] gray_in;
    logic [WIDTH-1:0] binary_out;

    // Instantiate Device Under Test (DUT)
    gray_code_unit #(
        .WIDTH(WIDTH)
    ) dut (
        .binary_in (binary_in),
        .gray_out  (gray_out),
        .gray_in   (gray_in),
        .binary_out(binary_out)
    );

    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, tb_gray_code_unit);
    end

    // Track test status
    int error_count = 0;

    initial begin
        $display("\n--- Starting Gray Code Unit Self-Checking Testbench ---");

        // Directed Test Loop: Iterate through all valid 4-bit values
        for (int i = 0; i < (1 << WIDTH); i++) begin
            
            // 1. Test Binary-to-Gray
            binary_in = i[WIDTH-1:0];
            #10; // Allow combinational propagation
            
            // Single bit-flip check relative to previous value
            if (i > 0) begin
                logic [WIDTH-1:0] prev_gray, gray_diff;
                prev_gray = (i - 1) ^ ((i - 1) >> 1);
                gray_diff = gray_out ^ prev_gray;

                // $onehot checks if exactly 1 bit transitioned
                if (!$onehot(gray_diff)) begin
                    $error("[FAIL] Multi-bit transition! Bin: %0d | Prev Gray: %b | Curr Gray: %b", 
                           i, prev_gray, gray_out);
                    error_count++;
                end
            end

            // 2. Test Roundtrip (Gray-to-Binary)
            gray_in = gray_out;
            #10; // Allow combinational propagation

            if (binary_out !== binary_in) begin
                $error("[FAIL] Roundtrip mismatch! Expected Bin: %b | Got: %b (Gray: %b)", 
                       binary_in, binary_out, gray_in);
                error_count++;
            end else begin
                $display("[PASS] Bin: %b (%2d) --> Gray: %b --> Recon Bin: %b", 
                         binary_in, binary_in, gray_out, binary_out);
            end
        end

        // Final Report
        $display("-----------------------------------------------------");
        if (error_count == 0) begin
            $display("SUCCESS: All tests passed with 0 errors.");
        end else begin
            $display("FAILURE: Completed with %0d error(s).", error_count);
        end
        $display("-----------------------------------------------------\n");
        $finish;
    end

endmodule