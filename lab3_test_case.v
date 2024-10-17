// https://www.tutorialspoint.com/compile_verilog_online.php
module main;
     reg [3:0] x;       // Declare x as a register since it is assigned in initial block
     wire [6:0] seg;    // 7-segment display output wire
    
     // segment a = x3'x2x0 + x2x1 + x3'x1 + x3x0' + x3x2'x1' + x2'x0'
     assign seg[0] = (~x[3] & x[2] & x[0]) | (x[2] & x[1]) | (~x[3] & x[1]) | 
                     (x[3] & ~x[0]) | (x[3] & ~x[2] & ~x[1]) | (~x[2] & ~x[0]);

     // segment b = x3'x2' + x2'x0' + x3'x1'x0' + x3'x1x0 + x3x1'x0
     assign seg[1] = (~x[3] & ~x[2]) | (~x[2] & ~x[0]) | (~x[3] & ~x[1] & ~x[0]) |
                     (~x[3] & x[1] & x[0]) | (x[3] & ~x[1] & x[0]);

     // segment e = x3x2 + x3x1 + x2'x0' + x1x0'
     assign seg[4] = (x[3] & x[2]) | (x[3] & x[1]) | (~x[2] & ~x[0]) | (x[1] & ~x[0]);

     // segment g = x1x0' + x3x2' + x3x0 + x2'x1 + x3'x2x1'
     assign seg[6] = (x[1] & ~x[0]) | (x[3] & ~x[2]) | (x[3] & x[0]) | 
                     (~x[2] & x[1]) | (~x[3] & x[2] & ~x[1]);
                     
     assign seg[2] = (~x[3]&~x[1]) | (~x[3]&x[0]) | (~x[1]&x[0]) | (~x[3]&x[2]) | (x[3]&~x[2]);
     
     assign seg[3] = (x[3] & ~x[1]) | (~x[3] & ~x[2] & ~x[0]) | (~x[2] & x[1] & x[0]) | (x[2] & ~x[1] & x[0]) | (x[2] & x[1] & ~x[0]);
     
     assign seg[5] = (~x[1] & ~x[0]) | (x[2] & ~x[0]) | (x[3] & ~x[2]) | (x[3] & x[1]) | (~x[3] & x[2] & ~x[1]);
     
  initial begin
     x = 4'b0000;       // Initialize x with a value
     #10;  // Add a small delay to ensure that seg values are properly calculated
     $display("x = %b, gfedcba seg = %b", x, seg);
     x = 4'b0001;       // Initialize x with a value
     #10;  // Add a small delay to ensure that seg values are properly calculated
     $display("x = %b, gfedcba seg = %b", x, seg);
     x = 4'b0010;       // Initialize x with a value
     #10;  // Add a small delay to ensure that seg values are properly calculated
     $display("x = %b, gfedcba seg = %b", x, seg);
     x = 4'b0011;       // Initialize x with a value
     #10;  // Add a small delay to ensure that seg values are properly calculated
     $display("x = %b, gfedcba seg = %b", x, seg);
     
     x = 4'b0100;       // Initialize x with a value
     #10;  // Add a small delay to ensure that seg values are properly calculated
     $display("x = %b, gfedcba seg = %b", x, seg);
     x = 4'b0101;       // Initialize x with a value
     #10;  // Add a small delay to ensure that seg values are properly calculated
     $display("x = %b, gfedcba seg = %b", x, seg);
     x = 4'b0110;       // Initialize x with a value
     #10;  // Add a small delay to ensure that seg values are properly calculated
     $display("x = %b, gfedcba seg = %b", x, seg);
     x = 4'b0111;       // Initialize x with a value
     #10;  // Add a small delay to ensure that seg values are properly calculated
     $display("x = %b, gfedcba seg = %b", x, seg);
     
     x = 4'b1000;       // Initialize x with a value
     #10;  // Add a small delay to ensure that seg values are properly calculated
     $display("x = %b, gfedcba seg = %b", x, seg);
     x = 4'b1001;       // Initialize x with a value
     #10;  // Add a small delay to ensure that seg values are properly calculated
     $display("x = %b, gfedcba seg = %b", x, seg);
     x = 4'b1010;       // Initialize x with a value
     #10;  // Add a small delay to ensure that seg values are properly calculated
     $display("x = %b, gfedcba seg = %b", x, seg);
     x = 4'b1011;       // Initialize x with a value
     #10;  // Add a small delay to ensure that seg values are properly calculated
     $display("x = %b, gfedcba seg = %b", x, seg);
     
     x = 4'b1100;       // Initialize x with a value
     #10;  // Add a small delay to ensure that seg values are properly calculated
     $display("x = %b, gfedcba seg = %b", x, seg);
     x = 4'b1101;       // Initialize x with a value
     #10;  // Add a small delay to ensure that seg values are properly calculated
     $display("x = %b, gfedcba seg = %b", x, seg);
     x = 4'b1110;       // Initialize x with a value
     #10;  // Add a small delay to ensure that seg values are properly calculated
     $display("x = %b, gfedcba seg = %b", x, seg);
     x = 4'b1111;       // Initialize x with a value
     #10;  // Add a small delay to ensure that seg values are properly calculated
     $display("x = %b, gfedcba seg = %b", x, seg);
     
     $finish;
  end
endmodule
