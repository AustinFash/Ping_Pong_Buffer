module top_ping_pong_buffer (
    input  logic        clk,
    input  logic        rst,
    input  logic [17:0] SW,                // SW[17]: write_en, SW[16]: read_en, SW[7:0]: write_data
    output logic [6:0]  display_write,     // Seven-segment display for Write Data
    output logic [6:0]  display_read,      // Seven-segment display for Read Data
    output logic        buffer_write_active, // LED indicator
    output logic        buffer_read_active,  // LED indicator
    output logic        buffer_full,       // LED indicator
    output logic        buffer_empty       // LED indicator
);

    // Control Signals
    logic write_en;
    logic read_en;
    logic [7:0] write_data;
    logic [7:0] read_data; // 

    assign write_en   = SW[17];
    assign read_en    = SW[16];
    assign write_data = SW[7:0];

    // Status Signals from Buffer
    logic write_full_internal;
    logic read_empty_internal;

    // Buffer Indicators
    logic current_write_buffer;
    logic current_read_buffer;

    // Slow Clock for Observable Operations
    logic slow_clk;

    // Clock Divider Module
    clock_divider clk_div_inst (
        .clk_in(clk),
        .rst(rst),
        .clk_out(slow_clk)
    );

    // Instantiate the Ping-Pong Buffer with slowed clock
    ping_pong_buffer ping_pong_inst (
        .clk                  (slow_clk),
        .rst                  (rst),
        .write_en             (write_en),
        .write_data           (write_data),
        .write_full           (write_full_internal),
        .read_en              (read_en),
        .read_data            (read_data), 
        .read_empty           (read_empty_internal),
        .current_write_buffer (current_write_buffer),
        .current_read_buffer  (current_read_buffer)
    );

    // Instantiate the Display Module for Write Data
    display display_write_inst (
        .data_in(write_data[3:0]),    // Display lower 4 bits of write_data
        .segments(display_write)
    );

    // Instantiate the Display Module for Read Data
    display display_read_inst (
        .data_in(read_data[3:0]),     // Display lower 4 bits of read_data
        .segments(display_read)
    );

    // Assign Buffer Status Indicators to LEDs
    assign buffer_write_active = current_write_buffer;
    assign buffer_read_active  = current_read_buffer;
    assign buffer_full         = write_full_internal;
    assign buffer_empty        = read_empty_internal;

endmodule
