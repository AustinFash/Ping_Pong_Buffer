# 🎾 Ping Pong Buffer 

---

## 🏓 About This Project

Welcome to the **Ping Pong Buffer** repository! This project was crafted as part of my **Digital System Design** course (14:332:437:04) to put my Verilog and FPGA skills to the test. Inspired by the fun and rhythm of a ping pong game, this dual-buffer system ensures continuous and efficient data flow—no more data collisions or delays! Plus, I had a great time building it! 🥳

---

## 🤔 What is a Ping Pong Buffer?

A Ping Pong Buffer is a clever dual-buffer memory system that alternates between two buffers to manage data seamlessly:

- **Buffer A:** Handles data writing.
- **Buffer B:** Processes data reading.

By switching back and forth, the system guarantees uninterrupted data flow, making it perfect for real-time applications like multimedia processing, signal processing, and data acquisition. Think of it as a well-coordinated dance where each buffer takes its turn to shine!

---

## 🚀 Key Features

- **Dual-Buffer Design:** Seamlessly alternates between two buffers for smooth data handling.
- **Configurable:** Easily adjust buffer size and data width to suit various needs.
- **FPGA Implementation:** Designed and tested on an FPGA to ensure real-world functionality.
- **Optimized for Real-Time Systems:** Efficiently handles high-speed, continuous data streams without missing a beat.

---

## 🎯 Purpose of the Project

The main goal of this project was to deepen my understanding of digital system design principles and translate theoretical concepts into a functional Verilog implementation. Building the Ping Pong Buffer pushed me to tackle synchronization challenges and refine the design for robust and reliable performance. Plus, it was a lot of fun seeing everything work together smoothly!

---

## 🛠️ Design Challenges and Solutions

- **Synchronization Struggles:** Ensuring read and write operations stayed in sync was tricky. Initially, a single buffer led to timing conflicts and data hiccups.
  - **Solution:** Introduced independent control logic for each buffer, allowing seamless transitions and maintaining data integrity.
  
- **Data Integrity Dilemmas:** Preventing data loss or corruption during buffer switches required careful planning.
  - **Solution:** Implemented robust synchronization mechanisms to keep data intact during transitions.

Through these challenges, I not only solidified my digital design skills but also discovered that debugging can sometimes be as satisfying as a perfect ping pong serve!

---

## 📂 Code Overview

The project is organized into several key modules:

- **Top-Level Module:** `top_ping_pong_buffer.sv`
  - Integrates all components into a cohesive FPGA-compatible design.
  
- **Ping Pong Buffer Logic:** `ping_pong_buffer.sv`
  - Core logic for alternating buffer operations.
  
- **Display Module:** `display.sv`
  - Manages visualization of buffer activity and data on an FPGA display.
  
- **Clock Divider:** `clock_divider.sv`
  - Slows down the clock for observable FPGA operations.

---

## 🧪 How to Test

1. Clone the Repository:
2. Open in Quartus: Load the provided Verilog files into Quartus.

3. Configure Settings: Adjust data width and buffer size as needed in the code.

4. Deploy to FPGA: Upload the design to your FPGA board.

5. Operate the Buffer:

  - Use switches to enable write and read operations.
  - Watch the LED indicators and display module to observe buffer activity in action!

---

## 📊 Test Waveforms

To ensure the Ping Pong Buffer operates correctly, I conducted extensive waveform simulations. Below are some key test waveforms demonstrating the synchronization and data flow between the buffers.

---

## 📌 Pin Assignments

Proper pin assignments are crucial for the FPGA implementation. Here's a screenshot of the pin assignments used in this project:

--- 

## 👨‍💻 Author

**Austin Fash**  
📅 December 2, 2024  
👨‍🏫 Instructor: Professor Predrag Spasojevic  

---

## 📜 License

This project is licensed under the MIT License. Feel free to use, modify, and share it as you like—just keep the good vibes and data flowing! 😎

