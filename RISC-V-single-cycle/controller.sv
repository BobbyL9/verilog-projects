module controller(
input logic [6:0] op,
input logic [2:0] funct3,
input logic funct7b5, 
input logic zero,
output logic [1:0] resultsrc,
output logic memwrite,
output logic pcsrc, alusrc, 
output logic regwrite, jump,
output logic [1:0] immsrc,
output logic [2:0] alucontrol
    );
    
logic [1:0] aluop;
logic branch;

// main decoder instantiation
maindec md(
    op, resultsrc, memwrite, branch, alusrc, regwrite,
    jump, immsrc, aluop
);

// alu decoder instantiation
aludec ad(
    op[5], funct3, funct7b5, aluop, alucontrol
);

assign pcsrc = branch & zero | jump;
endmodule
