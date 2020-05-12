module SS_Driver(
    input Clk, Reset, pwmClk, duty,
    input [3:0] BCD3, BCD2, BCD1, BCD0, // Binary-coded decimal input
    output reg [7:0] holder, // Digit drivers (active low)
    output reg [7:0] SevenSegment1 // Segments (active low)
);


// Make use of a subcircuit to decode the BCD to seven-segment (SS)
wire [6:0]SS[3:0];
BCD_Decoder BCD_Decoder0 (BCD0, SS[0]);
BCD_Decoder BCD_Decoder1 (BCD1, SS[1]);
BCD_Decoder BCD_Decoder2 (BCD2, SS[2]);
BCD_Decoder BCD_Decoder3 (BCD3, SS[3]);


// Counter to reduce the 100 MHz clock to 762.939 Hz (100 MHz / 2^17)
//reg [16:0]Count;
reg [16:0]Count;
reg [14:0] Count2;

    reg driverClk = 1'b0;

    parameter Driver_Frequency = 20000*10; //Hz
    parameter Clock_Frequency = 100000000; //100MHz
    reg [31:0] counter_value = (Clock_Frequency/Driver_Frequency);

    always@(posedge Clk) begin
        counter_value = counter_value - 1;
        if(counter_value == 0) begin
            driverClk <= !driverClk;
            counter_value <= (Clock_Frequency/Driver_Frequency);
        end
    end

reg [7:0] SegmentDrivers1;
// Scroll through the digits, switching one on at a time
always @(posedge Clk) begin
 Count <= Count + 1'b1;
 if ( Reset) SegmentDrivers1 = 8'hFE;
 else if(&Count) SegmentDrivers1 = {SegmentDrivers1[6:0], SegmentDrivers1[7]};
end

//------------------------------------------------------------------------------
always @(*) begin // This describes a purely combinational circuit
    if (pwmClk) holder = SegmentDrivers1;
    else holder = 8'hFF;
    SevenSegment1[7] <= 1'b1; // Decimal point always off
    if (Reset) begin
        SevenSegment1[6:0] <= 7'h7F; // All off during Reset
    end else begin
        case(~holder) // Connect the correct signals,
            8'h1 : SevenSegment1[6:0] <= ~SS[0]; // depending on which digit is on at
            8'h2 : SevenSegment1[6:0] <= ~SS[1]; // this point
            8'h4 : SevenSegment1[6:0] <= ~SS[2];
            8'h8 : SevenSegment1[6:0] <= ~SS[3];
            default: SevenSegment1[6:0] <= 7'h7F;
        endcase
    end
    
end

endmodule