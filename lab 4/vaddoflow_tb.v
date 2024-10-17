`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.02.2020 16:12:06
// Design Name: 
// Module Name: vsevenseg_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vsevenseg_tb(
    );
    
    // Inputs injected to UUT
	reg [3:0] a, b;

	// Outputs observed from UUT
	wire [6:0] seg_L;
	wire [3:0] digit;
	wire oflow;

	// Instantiate the Unit Under Test (UUT)
	// module name and port names must follow design source
	vaddoflow uut1 (
		.a(a), .b(b),
		.seg_L(seg_L),
        .oflow(oflow)
	);

	initial begin
		// $dumpfile("dump.vcd"); $dumpvars; // For EDA Playground

		// Initialize Inputs
		a = 0;
        b = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		// test vectors for 7-segment decoder
		// Set 4-bit input to a new value every 10 time units

        #10 a = 4'h5;

		#10 b = 4'h0;		// x = 0000 (binary)
		#10 b = 4'h1;		// x = 0001 (binary)
		#10 b = 4'h2;			
		#10 b = 4'h3;			
		#10 b = 4'h4;			
		#10 b = 4'h5;			
		#10 b = 4'h6;			
		#10 b = 4'h7;			
		#10 b = 4'h8;			
		#10 b = 4'h9;					
		#10 b = 4'ha;			
		#10 b = 4'hb;			
		#10 b = 4'hc;			
		#10 b = 4'hd;			
		#10 b = 4'he;			
		#10 b = 4'hf;		// x = 1111 (binary)

		#10 ;						
	end
endmodule

