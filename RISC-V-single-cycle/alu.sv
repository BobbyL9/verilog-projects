module alu
(
    input logic [31:0] srca, srcb,
    input logic [3:0] alucontrol,
    output logic [31:0] aluresult,
    output logic zero
);

// 3-bit wide alucontrol determines what operation to perform on the two sources, A and B
// 000 = addition
// 001 = subtraction
// 101 = slt, slti
// 011 = or, ori
// 010 = and, andi
// immediate values are handled in the srcb mux before srcb reaches the ALU

always_comb
    case (alucontrol)
        3'b000: aluresult = srca + srcb;
        3'b001: aluresult = srca - srcb;
        3'b101: aluresult = (srca < srcb) ? 32'd1 : 32'd0;
        3'b011: aluresult = srca | srcb;
        3'b010: aluresult = srca & srcb;
    endcase
    
    assign zero = (aluresult == 32'd0) ? 1 : 0;

endmodule
