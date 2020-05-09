`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.05.2020 11:56:48
// Design Name: 
// Module Name: PWM
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


module PWM(
    input clk,
    input [7:0] duty,
    output out
    );
    
    parameter PWM_Frequency = 1000; //Hz
    parameter Clock_Frequency = 100000000; //100MHz
    reg out = 1'b0;
    reg [31:0] counter_value = (Clock_Frequency/PWM_Frequency);

    always@(posedge clk) begin
        counter_value = counter_value - 1;
        if(counter_value == 0) begin
            counter_value = (Clock_Frequency/PWM_Frequency);
        end
        if(counter_value > ((duty*(Clock_Frequency/PWM_Frequency)/255))) begin
            out = 1'b0;
        end 
        else begin
            out = 1'b1;
        end
    end
    
endmodule
