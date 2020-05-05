`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2020 11:55:16
// Design Name: 
// Module Name: custom_counter_sim
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


module custom_counter_sim(
    );
    reg counter_tick = 1'b0;
    
    wire overflow_sec,overflow_min,overflow_hour;
    wire [5:0] sec, min, hour;
    
    custom_counter cc_sec (.count_without_overflow(counter_tick), .overflow(overflow_sec), .count_to(6'd59), .current_count(sec));
    custom_counter cc_min (.count_with_overflow(overflow_sec), .overflow(overflow_min), .count_to(6'd59), .current_count(min));
    custom_counter cc_hour (.count_with_overflow(overflow_min), .overflow(overflow_hour), .count_to(6'd23), .current_count(hour));
    
    always begin
        #5;
        counter_tick = 1'b0;
        #5;
        counter_tick = 1'b1;
    end
endmodule
