`timescale 1ns / 1ps

module top(
    // These signal names are for the nexys A7. 
    // Check your constraint file to get the right names
    input  CLK100MHZ,
    input [7:0] SW,
    input BTNL,
    output AUD_PWM, 
    output AUD_SD,
    output [2:0] LED
    );
    
    // Toggle arpeggiator enabled/disabled
    wire arp_switch;
    reg arp_state = 0;
    Debounce change_state (CLK100MHZ, BTNL, arp_switch); // ensure your button choice is correct
    
    // Memory IO
    reg ena = 1;
    reg wea = 0;
    reg [7:0] addra=0;
    reg [10:0] dina=0; //We're not putting data in, so we can leave this unassigned
    wire [10:0] douta;
    
    
    // Instantiate block memory here
    fullsine your_instance_name (
        .clka(CLK100MHZ),    // input wire clka
        .ena(ena),      // input wire ena
        .wea(wea),      // input wire [0 : 0] wea
        .addra(addra),  // input wire [7 : 0] addra
        .dina(dina),    // input wire [10 : 0] dina
        .douta(douta)  // output wire [10 : 0] douta
    );    
    //PWM Out - this gets tied to the BRAM
    reg [10:0] PWM;
    
    // Instantiate the PWM module
    pwm_module PWM1 (CLK100MHZ, PWM, AUD_PWM);
    // PWM should take in the clock, the data from memory
    // PWM should output to AUD_PWM (or whatever the constraints file uses for the audio out.
    
    // Devide our clock down
    reg [12:0] clkdiv = 0;
    
    // keep track of variables for implementation
    reg [26:0] note_switch = 0;
    reg [1:0] note = 0;
    reg [11:0] f_base = 0;
    
    always @(posedge arp_switch) begin
        arp_state = !arp_state;
    end
    
always @(posedge CLK100MHZ) begin   
    PWM <= douta; // tie memory output to the PWM input
    f_base = 746 + SW[7:0]; // get the "base" frequency to work from 
    
    clkdiv <= clkdiv + 1'b1;
    
    if (arp_state) begin
        // FSM to switch between notes, otherwise just output the base note.
        note_switch = note_switch + 1;
        if (note_switch == 50000000) begin
            note = note +1;
            note_switch = 0;
        end
        case (note)
            0: begin
                if (clkdiv >= f_base*2) begin
                    clkdiv[12:0] <= 0;
                    addra <= addra + 1;
                end
            end
            1: begin
                if (clkdiv >= f_base*5/4) begin
                    clkdiv[12:0] <= 0;
                    addra <= addra + 1;
                end
            end
            2: begin
                if (clkdiv >= f_base*3/2) begin
                    clkdiv[12:0] <= 0;
                    addra <= addra + 1;
                end
            end
            3: begin
                if (clkdiv >= f_base) begin
                    clkdiv[12:0] <= 0;
                    addra <= addra + 1;
                end
            end
            default: begin
                if (clkdiv >= 1493) begin
                    clkdiv[12:0] <= 0;
                    addra <= addra + 1;
                end
            end
        endcase;
    end 
    else begin
        if (clkdiv >= 1493) begin
            addra <= addra + 1'b1;
            clkdiv <= 0;
        end
    end
end


assign AUD_SD = 1'b1;  // Enable audio out
assign LED[1:0] = note[1:0]; // Tie FRM state to LEDs so we can see and hear changes


endmodule
