/*
# Filename:         pwm_generator.v
# File Description: This file implements a PWM generator that produces a PWM signal 
#                   with configurable duty cycle and a divided clock (195kHz) from 
#                   the input 3.125MHz clock.
# Global variables: None
*/


module pwm_generator(
    input clk_3125KHz,                // Input clock at 3.125 MHz
    input [3:0] duty_cycle,           // Duty cycle control (0–15, representing 0%–100%)
    output reg clk_195KHz,            // Output divided clock (195 kHz)
    output reg pwm_signal             // Output PWM signal
);

initial begin
    clk_195KHz = 0; 
    pwm_signal = 1;
end
// pwm_counter: counts from 0 to 15 for generating PWM steps
reg [3:0] pwm_counter = 0;      

// clk_div_counter: counts from 0 to 7 for dividing 3.125 MHz clock to 195 kHz
reg [2:0] clk_div_counter = 0;  


//---------------- PWM Generation Block ----------------//
always @(posedge clk_3125KHz) begin
    /*
    Purpose:
    ---
    This block generates the PWM signal based on the duty_cycle input.
    It counts from 0 to 15 and compares the counter value with duty_cycle
    to decide whether the PWM signal is HIGH or LOW.
    */

    if (pwm_counter == 15)          // Wrap counter after 16 counts (0–15)
        pwm_counter <= 0;
    else
        pwm_counter <= pwm_counter + 1'b1;

    pwm_signal <= (pwm_counter < duty_cycle) ? 1'b1 : 1'b0; // HIGH until counter < duty_cycle
end


//---------------- Clock Divider Block ----------------//
always @(posedge clk_3125KHz) begin
    /*
    Purpose:
    ---
    This block divides the input 3.125 MHz clock to generate a 195 kHz clock.
    It uses a modulo-8 counter and toggles clk_195KHz every time the counter
    resets to zero.
    */

    if (!clk_div_counter)
        clk_195KHz = ~clk_195KHz; // Toggle clk_195KHz when counter is zero

    clk_div_counter = clk_div_counter + 1'b1; // Increment divider counter

    if (clk_div_counter == 8)
        clk_div_counter = 0; // Reset after reaching 8
end


endmodule
