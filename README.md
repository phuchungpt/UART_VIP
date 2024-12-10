Verification IP (VIP) Development and Testing Project

Project Overview

This project involves the development and testing of a Verification IP (VIP) for a UART protocol. The primary goals include creating a robust verification plan, implementing necessary components (such as transaction, interface, configuration, agent, scoreboard, and testbench), and ensuring thorough testing and debugging to validate the VIP's functionality and reliability.

Project Components

Verification Plan: A comprehensive plan outlining scenarios, coverage points, and testing strategies for the VIP.

Transaction: Defines a flexible transaction model allowing users to control the stimulus generation, ensuring modularity and reusability.

Interface: Implements an interface to connect and control the real UART interface seamlessly.

Configuration: Provides configurable parameters for the VIP's operational modes, making it adaptable for different testing requirements.
Agent: Contains the following sub-components:

Sequencer: Controls the sequence of transactions.

Driver: Drives transactions onto the interface.

Monitor: Observes and extracts data, operating in:

ACTIVE mode: Full-featured monitoring with stimulus generation.

PASSIVE mode: Non-intrusive observation only.

Scoreboard: Compares expected and actual data to ensure data integrity and correctness.

Testbench Environment

Includes packages for:

Sequence generation

Test implementation

Environment setup

Supports compilation and seamless integration with simulators.

Test Cases: 

Includes various scenarios auch as:

Same configuration testing.

Different configuration testing.

Improvements and enhancements to the VIP functionality.

Debugging and Waveform Analysis

Thorough analysis of simulation waveforms, debugging, and resolving verification issues.

![image](https://github.com/user-attachments/assets/f00fdd2b-b867-40d6-8860-c9b0837b3e49)

![image](https://github.com/user-attachments/assets/7914b6c6-870d-4ed6-94df-7dfc8b04564d)

![image](https://github.com/user-attachments/assets/4b6114dd-0914-4fca-82b7-b763f71d03b2)

- UART TX is high when idle
- Start Bit: Signals the beginning of data transmission, usually a single low bit.
- Data Bits: Typically 5 to 9 bits representing the actual data.
- Parity Bit (optional): Error-checking bit to detect single-bit errors.
- Stop Bit(s): Indicates the end of data transmission, typically one or two high bits.
- Baud Rate: Defines the rate of data transmission in bits per second (bps) and needs to match on
both transmitting and receiving UART. Common baud rate: 4800, 9600, 19200, 57600 and
115200
