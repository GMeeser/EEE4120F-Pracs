`timescale 1ns / 1ps

module PWM(
    input clk,
    input [7:0] duty,
    output reg out
    );
    
    parameter PWM_Frequency = 7629; //Hz
    parameter Clock_Frequency = 100000000; //100MHz
    reg [31:0] counter_value = (Clock_Frequency/PWM_Frequency);
    
    reg[16:0] count;
   
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
