`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.05.2020 12:18:10
// Design Name: 
// Module Name: PWM_sim
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


module PWM_sim(
    );
    reg counter_tick = 1'b0;
    
    wire pwm, out;
    reg [7:0] duty = 51;
    
    PWM test1(.clk(counter_tick), .duty(duty), .out(out));
    
    
    always begin
        #5;
        counter_tick = 1'b0;
        #5;
        counter_tick = 1'b1;
    end
    
    always begin
        #900000
        duty = 10;
    end
    
    
endmodule
