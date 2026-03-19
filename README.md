# PWM Generator

## Overview
This project implements a **Pulse Width Modulation (PWM) generator** in **Verilog HDL**.  
It generates a PWM signal with a configurable duty cycle and also produces a **195 kHz clock** by dividing an input **3.125 MHz clock**.

PWM is widely used in digital systems for controlling **motor speed, LED brightness, and power delivery**.

---

## Features
- Configurable **4-bit duty cycle control (0–15)**
- **16-step PWM resolution**
- Generates **PWM output signal**
- **Clock divider** producing ~195 kHz from 3.125 MHz
- Synthesizable Verilog design suitable for FPGA implementation

---

## Working Principle

### PWM Generation
A **4-bit counter** counts from **0 to 15** and compares its value with the input duty cycle.

If  
pwm_counter < duty_cycle  

then the PWM output is HIGH, otherwise it is LOW.

Example:

| Duty Cycle | Output |
|------------|--------|
| 0 | 0% |
| 8 | 50% |
| 15 | ~100% |

---

### Clock Division
The input clock **3.125 MHz** is divided using a counter to generate an output clock of approximately **195 kHz**.

---

## Module Ports

| Port | Description |
|-----|-------------|
| clk_3125KHz | Input clock (3.125 MHz) |
| duty_cycle[3:0] | Duty cycle control |
| clk_195KHz | Divided clock output |
| pwm_signal | Generated PWM signal |

---

## File Structure
```
pwm_generator
  - pwm_generator.v
  - README.md
```
---

## Tools Used
- Verilog HDL
- ModelSim / QuestaSim
- Intel Quartus Prime

---

## Applications
- Motor speed control
- LED dimming
- Power electronics
- Embedded and FPGA systems
