// =============================================================
// 2-Flip-Flop Synchronizer for CDC (Metastability Hardening)
// =============================================================
module sync_2ff (
    input  wire clk,          // Destination clock domain
    input  wire async_in,     // Asynchronous or other-domain signal
    output wire sync_out      // Synchronized output
);

    // First-stage flip-flop (may go metastable)
    reg ff1;
    // Second-stage flip-flop (reduces metastability probability)
    reg ff2;

    always @(posedge clk) begin
        ff1 <= async_in;   // capture async signal
        ff2 <= ff1;        // second stage to settle metastability
    end

    assign sync_out = ff2;

endmodule