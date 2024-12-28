module clock_divider (
    input  logic clk_in,  // Input clock signal
    input  logic rst,     // Reset signal (active high)
    output logic clk_out  // Output divided clock signal
);
    parameter DIV_FACTOR = 25_000_000; // Factor that controls speed

    logic [$clog2(DIV_FACTOR)-1:0] counter;

    always_ff @(posedge clk_in or posedge rst) begin
        if (rst) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            if (counter == DIV_FACTOR - 1) begin
                counter <= 0;
                clk_out <= ~clk_out; // Toggle output clock
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule
