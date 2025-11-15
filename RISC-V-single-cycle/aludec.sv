module aludec(
    input logic opb5, funct7b5,
    input logic [1:0] aluop,
    input logic [2:0] funct3,
    output logic [2:0] alucontrol
    );
    
logic rtypesub;

assign rtypesub = funct7b5 & opb5; //true for r-type subtraction

always_comb
    case(aluop)
        2'b00 : alucontrol = 3'b000; //addition
        2'b01 : alucontrol = 3'b001; //subtraction
        default : case(funct3) //r-type or i-type alu
                    3'b000: if (rtypesub)
                                alucontrol = 3'b001; //subtraction
                            else
                                alucontrol = 3'b000; // add, addi
                    3'b010 : alucontrol = 3'b101; // slt, slti
                    3'b110 : alucontrol = 3'b011; // or, ori
                    3'b111 : alucontrol = 3'b010; //and, andi
                    default: alucontrol = 3'bxxx;
                 endcase
    endcase
endmodule
