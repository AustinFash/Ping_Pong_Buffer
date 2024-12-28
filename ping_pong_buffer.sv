module ping_pong_buffer #(
    parameter int DATA_WIDTH = 8,
    parameter int BUFFER_SIZE = 16
) (
    input  logic                  clk,
    input  logic                  rst,
    input  logic                  write_en,
    input  logic [DATA_WIDTH-1:0] write_data,
    output logic                  write_full,
    input  logic                  read_en,
    output logic [DATA_WIDTH-1:0] read_data,
    output logic                  read_empty,
    output logic                  current_write_buffer,
    output logic                  current_read_buffer
);

    // Internal buffers
    logic [DATA_WIDTH-1:0] buffer_a [0:BUFFER_SIZE-1];
    logic [DATA_WIDTH-1:0] buffer_b [0:BUFFER_SIZE-1];

    // Buffer state control
    logic write_buffer;                        // 0: buffer_a, 1: buffer_b
    logic read_buffer;                         // 0: buffer_a, 1: buffer_b
    logic [$clog2(BUFFER_SIZE)-1:0] write_ptr; // Write pointer
    logic [$clog2(BUFFER_SIZE)-1:0] read_ptr;  // Read pointer
    logic buffer_ready [1:0];                  // buffer_ready[0]: buffer_a, buffer_ready[1]: buffer_b

    // Assign buffer selection outputs
    assign current_write_buffer = write_buffer;
    assign current_read_buffer  = read_buffer;

    always_ff @(posedge clk or posedge rst) begin
	 
		  // Reset all state variables
        if (rst) begin
            write_buffer       <= 0;
            read_buffer        <= 0;
            write_ptr          <= 0;
            read_ptr           <= 0;
            buffer_ready[0]    <= 0;
            buffer_ready[1]    <= 0;
            write_full         <= 0;
            read_empty         <= 1;
            read_data          <= 0;
				
        end else begin
		  
            // Write Process 
            if (write_en && !write_full) begin
				
                // Write data to the active buffer
                if (write_buffer == 0)
                    buffer_a[write_ptr] <= write_data;
						  
                else
                    buffer_b[write_ptr] <= write_data;

                // Increment write pointer
                write_ptr <= write_ptr + 1;

					 
                // Check if buffer is full after write
                if (write_ptr == BUFFER_SIZE - 1) begin
                    buffer_ready[write_buffer] <= 1; // Mark current buffer as ready
                    write_full <= (buffer_ready[~write_buffer]); // Set write_full if other buffer is also ready

						  
                    // Switch to the other buffer if it's not ready
                    if (!buffer_ready[~write_buffer]) begin
                        write_buffer <= ~write_buffer;
                        write_ptr    <= 0;
								
                    end
						  
                end
					 
            end else if (write_full) begin
				
                // Check if other buffer has become available
                if (!buffer_ready[~write_buffer]) begin
                    write_full   <= 0;
                    write_buffer <= ~write_buffer;
                    write_ptr    <= 0;
						  
                end
            end

				
				
            // Read Process
            if (read_en && !read_empty) begin
				
                // Read data from the active buffer
                if (read_buffer == 0)
                    read_data <= buffer_a[read_ptr];
						  
                else
                    read_data <= buffer_b[read_ptr];

						  
                // Increment read pointer
                read_ptr <= read_ptr + 1;

                // Check if buffer is empty after read
                if (read_ptr == BUFFER_SIZE - 1) begin
                    buffer_ready[read_buffer] <= 0; // Buffer has been read
                    read_empty <= (buffer_ready[~read_buffer] == 0); // Set read_empty if other buffer is not ready

                    // Switch to the other buffer if it's ready
                    if (buffer_ready[~read_buffer]) begin
                        read_buffer <= ~read_buffer;
                        read_ptr    <= 0;
                    end
						  
                end
					 
            end else if (read_empty) begin
				
                // Check if buffer has become ready
                if (buffer_ready[read_buffer]) begin
                    read_empty <= 0;
                    read_ptr   <= 0;
						  
                end else if (buffer_ready[~read_buffer]) begin
                    read_empty  <= 0;
                    read_buffer <= ~read_buffer;
                    read_ptr    <= 0;
						  
                end
					 
            end
				
				
				
        end
    end
endmodule
