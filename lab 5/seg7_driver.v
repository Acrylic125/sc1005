`timescale 1ns / 1ps
// ###########################################################################
// BASYS 3: 7 segment display driver.
// Inputs: clk, rst: 100MHz clk, active high rst.
// Inputs: sel: From push button 
// Inputs: value: 16-bit to display. MSB 4-bits is left digit. LSB 4-bits is right digit, etc.
// Inputs: anode_d: 4-bit anode driver input. Active low. MSB is left digit, LSB is right digit. 1111 is OFF.
// Outputs: seg_L: 7-bit active low segment.
// Outputs: anode_L: anode driver to select the correct 7 seg display.
// ##########################################################################
// 7 seg displays are refreshed using an ~95Hz slow clock.
// Each digit is active low for 2.6ms, reftesh every 10.5ms.
// ###########################################################################

module seg7_driver(
    input clk,                  // 100Mz system clock
    input rst,                  // Active high rst
    input sel,                  // The sel input
    input [15:0] value,       // the 4 digits to be displayed (each 4-bits)
    input [3:0] anode_d,        // active low 4-bit anode driver. 0000 turns all ON.
    output reg [6:0] seg_L,     // 7-bit active low segment
    output reg [3:0] anode_L    // anode driver output to select the correct 7 seg display
    );

	wire [1:0] seg7_clk;
	wire [15:0] value_sel;
	reg [19:0] count;      
    reg [3:0] selnum;

    // This always block and the following assign statement generate
    // The Two bit SLOW clock, from the 100MHz system clock (clk) for the 7 seg anodes
    always@(posedge(clk))
	   if (rst)        // rst is the middle push button
		  count <= 20'b0;
	   else
		  count <= count+1'b1;
		  
	assign seg7_clk = count[19:18];	   // select the 2 MSBs to drive the 7 seg anodes
	assign value_sel = (sel) ? {8'h22, benchNo_10, benchNo_1} : value;

	// This always block generates
	// 	1. The value displayed on each 7-seg display (selnum[3:0])
    //	2. The one-hot active low 7 seg display anode select signals (anode_L[3:0])
    always @ *          
    begin
         case (seg7_clk)    
            2'd0 :  begin
                        anode_L = {1'b1, 1'b1, 1'b1, anode_d[0]};
                        selnum = value_sel[3:0];
                    end
            2'd1 :  begin
                        anode_L = {1'b1, 1'b1, anode_d[1], 1'b1};
                        selnum = value_sel[7:4];
                    end
            2'd2 :  begin
                        anode_L = {1'b1, anode_d[2], 1'b1, 1'b1};
                        selnum = value_sel[11:8];
                    end
            2'd3 :  begin
                        anode_L = {anode_d[3], 1'b1, 1'b1, 1'b1};
                        selnum = value_sel[15:12];
                    end
        endcase
    end

// **************** You should NOT modify the code above ****************** //

// Enter your Bench Number here. If required, add the offset given
    wire [3:0] benchNo_10 = 4'd1;  // Enter the tens digit of YOUR bench number
    wire [3:0] benchNo_1 = 4'd9;   // Enter the ones digit of YOUR bench number


// the 7 -bit segments
    always @*
    begin
        case (selnum)
            4'd0  : seg_L = 7'b100_0000;
            4'd1  : seg_L = 7'b111_1001;
            4'd2  : seg_L = 7'b010_0100;
            4'd3  : seg_L = 7'b011_0000;            
            4'd4  : seg_L = 7'b001_1001;
            4'd5  : seg_L = 7'b001_0010;
            4'd6  : seg_L = 7'b000_0010;
            4'd7  : seg_L = 7'b111_1000;
            4'd8  : seg_L = 7'b000_0000;
            4'd9  : seg_L = 7'b001_0000;
            // 4'd10 : seg_L = 7'b000_1000; // For space _
            4'd11 : seg_L = 7'b010_0011; // For lowercase o
            4'd12 : seg_L = 7'b100_0110;
            4'd13 : seg_L = 7'b010_0001;
            4'd14 : seg_L = 7'b000_0110;
            4'd15 : seg_L = 7'b000_1110;        
            default:seg_L = 7'b111_1111;
        endcase
    end

endmodule
