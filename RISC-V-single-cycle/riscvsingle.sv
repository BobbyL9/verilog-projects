module riscvsingle(
    input logic clk, reset,
    output logic [31:0] pc,
    input logic [31:0] instr,
    output logic memwrite,
    output logic [31:0] aluresult, writedata,
    input logic [31:0] readData
    );
    
logic alusrc, regwrite, jump, zero;
logic [1:0] resultsrc, immsrc;
logic [2:0] alucontrol;

// controller instantiation
controller c(
    instr[6:0], instr[14:12], instr[30], zero,
    resultsrc, memwrite, pcsrc,
    alusrc, regwrite, jump,
    immsrc, alucontrol
);

// datapath instantiation
datapath dp(
    clk, reset, resultsrc, pcsrc,
    alusrc, regwrite,
    immsrc, alucontrol,
    zero, pc, instr,
    aluresult, writedata, readData
);
endmodule
