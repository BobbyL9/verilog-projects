module datapath(
input logic clk, reset,
input logic [1:0] resultsrc,
input logic pcsrc, alusrc,
input logic regwrite,
input logic [1:0] immsrc,
input logic [2:0] alucontrol,
output logic zero,
output logic [31:0] pc,
input logic [31:0] instr,
output logic [31:0] aluresult, writedata,
input logic [31:0] readData
    );
    
logic [31:0] pcnext, pcplus4, pctarget;
logic [31:0] immext;
logic [31:0] srca, srcb;
logic [31:0] result;

// next pc logic
flopr #(32) pcreg(clk, reset, pcnext, pc);
adder pcadd4(pc, 32'd4, pcplus4);
adder pcaddbranch(pc, immext, pctarget);
mux2 #(32) pcmux(pcplus4, pctarget, pcsrc, pcnext);

// register file logic
regfile rf(clk, regwrite, instr[19:15], instr[24:20], instr[11:7], result, srca, writedata);
extend ext(instr[31:7], immsrc, immext);

// alu logic
mux2 #(32) srcbmux(writedata, immext, alusrc, srcb);
alu alu(srca, srcb, alucontrol, aluresult, zero);
mux3 #(32) resultmux(aluresult, readData, pcplus4, resultsrc, result);
endmodule
