`timescale 1ns / 1ps



module WallClock(
	//inputs - these will depend on your board's constraint files
	input CLK100MHZ,
	input BTNC,
	input BTNR,
	input BTNL,
	input BTNU,
	input [7:0]SW,

	//outputs - these will depend on your board's constraint files
	output [7:0] SegmentDrivers,
    output [7:0] SevenSegment,
    output reg [7:0] LED
);
    reg [31:0] tick_speed = 100000000; // change to 100000000 for accurate seconds
   
    wire pwmClk;
    reg [7:0] duty;
    
    PWM PWM1 (CLK100MHZ, duty, pwmClk);

	//Add the reset
	wire Reset;
    Delay_Reset DReset(CLK100MHZ, BTNC, Reset);


	//Add and debounce the buttons
	wire MButton;
	wire HButton;
	wire switch_speed;
	
	// Instantiate Debounce modules here
	Debounce DebounceM (CLK100MHZ, BTNR, MButton);
	Debounce DebounceH (CLK100MHZ, BTNL, HButton);
	Debounce DebounceS (CLK100MHZ, BTNU, switch_speed);
	
	// registers for storing the time
    wire [3:0]hours1;
	wire [3:0]hours2;
	wire [3:0]mins1;
	wire [3:0]mins2;
	wire [3:0]secs1;
	wire [3:0]secs2;
	
	reg [7:0] s;
    
	//Initialize seven segment
	// You will need to change some signals depending on you constraints
	SS_Driver SS_Driver1(
		CLK100MHZ, Reset, pwmClk, duty,
		hours2, hours1, mins2, mins1, // Use temporary test values before adding hours2, hours1, mins2, mins1
		SegmentDrivers, SevenSegment
	);
	//The main logic
	
	wire overflow_sec;
	wire overflow_min;
	wire overflow_hour;
	
	
    reg [7:0] sec;
    reg [32:0] count;
	reg second_tick = 1'b0;
	reg c = 1'b0;
	custom_counter cc_sec (.Clk(CLK100MHZ), .count_with_overflow(second_tick), .count_without_overflow(c), .count_to2(4'd5), .count_to1(4'd9), .overflow(overflow_sec), .count2(secs2), .count1(secs1));
    custom_counter cc_min (.Clk(CLK100MHZ), .count_with_overflow(overflow_sec), .count_without_overflow(MButton), .count_to2(4'd5), .count_to1(4'd9), .overflow(overflow_min), .count2(mins2), .count1(mins1));
    custom_counter cc_hour (.Clk(CLK100MHZ), .count_with_overflow(overflow_min), .count_without_overflow(HButton), .count_to2(4'd2), .count_to1(4'd3), .overflow(overflow_hour), .count2(hours2), .count1(hours1));
	
	always @(posedge switch_speed) begin
	   if (tick_speed == 100000000) begin
	       tick_speed <= 10000000;
	   end else tick_speed <= 100000000;
	end
	
	always @(posedge CLK100MHZ) begin
	   if (count >= tick_speed/2) begin
	       second_tick = !second_tick;
	       count = 0;
	   end else count = count + 1'b1;
	   
	   s[3:0] = secs2;
	   s[7:4] = 4'b0;
	   s = s*10;
	   s = s + secs1;
	   LED[7:0] = s;
	   duty = SW;
	end
endmodule  
