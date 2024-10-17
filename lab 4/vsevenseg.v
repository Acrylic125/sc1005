// https://www.edaplayground.com/x/Cfu3
module vsevenseg(
    input [3:0] x, 
    output reg [6:0] seg_L
);
    always @ * begin 
        case (x) 
            4'b0000: seg_L = 7'b100_0000; // '0'
            4'b0001: seg_L = 7'b111_1001; // '1'
            4'b0010: seg_L = 7'b010_0100; // '2'
            4'b0011: seg_L = 7'b011_0000; // '3'
            4'b0100: seg_L = 7'b001_1001; // '4'
            4'b0101: seg_L = 7'b001_0010; // '5'
            4'b0110: seg_L = 7'b000_0010; // '6'
            4'b0111: seg_L = 7'b111_1000; // '7'
            4'b1000: seg_L = 7'b000_0000; // '8'
            4'b1001: seg_L = 7'b001_0000; // '9'
            4'b1010: seg_L = 7'b000_1000; // 'A'
            4'b1011: seg_L = 7'b000_0011; // 'B'
            4'b1100: seg_L = 7'b100_0110; // 'C'
            4'b1101: seg_L = 7'b010_0001; // 'D'
            4'b1110: seg_L = 7'b000_0110; // 'E'
            4'b1111: seg_L = 7'b000_1110; // 'F'

            default: seg_L = 7'b111_1111; // ' '
        endcase
    end
endmodule

module vaddoflow(
    input [3:0] a, b,
    output reg [6:0] seg_L,
    output oflow
);
    wire [4:0] sum_with_carry;
    assign sum_with_carry = a + b;
    assign oflow = sum_with_carry[4];

    vsevenseg show_sum(
        .x(sum_with_carry[3:0]),
        .seg_L(seg_L)
    );
    
endmodule