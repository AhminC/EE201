
module line_drawer(
	input logic clk, reset,
	
	// x and y coordinates for the start and end points of the line
	input logic [9:0]	x0, x1, 
	input logic [8:0] y0, y1,

	//outputs cooresponding to the coordinate pair (x, y)
	output logic [9:0] x,
	output logic [8:0] y
	);
	
	/*
	 * You'll need to create some registers to keep track of things
	 * such as error and direction
	 * Example: */
	logic steep;
	logic signed [11:0] error;
	logic signed [9:0] abs_x, x0_middle, x0_new, x1_middle, x1_new, px, x_out, delta_x;
	logic signed [8:0] abs_y, y0_middle, y0_new, y1_middle, y1_new, py, y_out, delta_y;
	logic signed ystep;
	
	//assigns absolute value of change of x and change y
	assign abs_x = (x1 > x0) ? (x1 - x0) : (x0 - x1);
	assign abs_y = (y1 > y0) ? (y1 - y0) : (y0 - y1);
	
	//assigns whether the line is steep or not
	assign steep = (abs_y > abs_x) ? 1'b1 : 1'b0;
	
	always_comb begin
		
		x0_middle = steep ? y0 : x0;
		x1_middle = steep ? y1 : x1;
		
		y0_middle = steep ? x0 : y0;
		y1_middle = steep ? x1 : y1;
		
	end
	
	always_comb begin
		x0_new = (x0_middle > x1_middle) ? x1_middle : x0_middle;
		x1_new = (x0_middle > x1_middle) ? x0_middle : x1_middle;
		y0_new = (x0_middle > x1_middle) ? y1_middle : y0_middle;
		y1_new = (x0_middle > x1_middle) ? y0_middle : y1_middle;
	end
	
	assign dx = x1_new - x0_new;
	assign dy = (y1_new > y0_new) ? (y1_new - y0_new) : ( y0_new - y1_new);
	

	always_comb begin
		if (y1_new - y0_new) begin
			ystep = 1;
		end else
			ystep = -1;
	end
	
	always_ff @(posedge clk) begin
		if(reset) begin
			px <= x0_new;
			py <= y0_new;
			error <= (-1) * dx / 2;
		end 
		else begin
			if (px <= x1_new) begin
				if (steep) begin
					x_out <= py;
					y_out <= px;
				end else begin
					x_out <= px;
					y_out <= py;
				end
				//error <= error + deltaY;
				if (error >= 0) begin
					if (ystep)
						py <= py + 1'b1;
					else begin
						py <= py - 1'b1;
					end
					error <= error - dx + dy;
				end else 
					error <= error + dy;
				px <= px + 1'b1;
			end
		end
	end
	
	assign x = x_out;
	assign y = y_out;
	
endmodule

module line_drawer_testbench();
	logic clk, reset;
	
	// x and y coordinates for the start and end points of the line
	logic [9:0]	x0, x1; 
	logic [8:0] y0, y1;

	//outputs cooresponding to the coordinate pair (x, y)
	logic [9:0] x;
	logic [8:0] y;
	
	line_drawer dut(.*);
	
	parameter CLOCK_PERIOD=100;  
	initial begin   
	  clk <= 0;  
	  forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
		initial begin
		// horizontal line
    	x0 = 0; x1 = 10; y0 = 0; y1 = 0; reset = 1;  @(posedge clk);
      x0 = 0; x1 = 10; y0 = 0; y1 = 0; reset = 0; repeat(30) @(posedge clk);
		
		// vertical line
      x0 = 0; x1 = 0; y0 = 0; y1 = 10; reset = 1;  @(posedge clk);
    	x0 = 0; x1 = 0; y0 = 0; y1 = 10; reset = 0; repeat(30) @(posedge clk);
		
		// right down line gradual case
		x0 = 0; x1 = 9; y0 = 0; y1 = 4; reset = 1;  @(posedge clk);
		x0 = 0; x1 = 9; y0 = 0; y1 = 4; reset = 0; repeat(20) @(posedge clk);

		// right down line steep case 
		x0 = 0; x1 = 4; y0 = 0; y1 = 9; reset = 1;  @(posedge clk);
		x0 = 0; x1 = 4; y0 = 0; y1 = 9; reset = 0; repeat(20) @(posedge clk);

		// right up line gradual case
		x0 = 0; x1 = 9; y0 = 4; y1 = 0; reset = 1;  @(posedge clk);
		x0 = 0; x1 = 9; y0 = 4; y1 = 0; reset = 0; repeat(20) @(posedge clk);

		// right up line steep case broken
		x0 = 0; x1 = 4; y0 = 9; y1 = 0; reset = 1;  @(posedge clk);
		x0 = 0; x1 = 4; y0 = 9; y1 = 0; reset = 0; repeat(20) @(posedge clk);

		// left up line steep case
		x0 = 4; x1 = 0; y0 = 9; y1 = 0; reset = 1;  @(posedge clk);
		x0 = 4; x1 = 0; y0 = 9; y1 = 0; reset = 0; repeat(20) @(posedge clk);

		// left up line gradual case
		x0 = 9; x1 = 0; y0 = 4; y1 = 0; reset = 1;  @(posedge clk);
		x0 = 9; x1 = 0; y0 = 4; y1 = 0; reset = 0; repeat(20) @(posedge clk);

		// left down line steep case
		x0 = 4; x1 = 0; y0 = 0; y1 = 9; reset = 1;  @(posedge clk);
		x0 = 4; x1 = 0; y0 = 0; y1 = 9; reset = 0; repeat(20) @(posedge clk);

		// left down line gradual case
		x0 = 9; x1 = 0; y0 = 0; y1 = 4; reset = 1;  @(posedge clk);
		x0 = 9; x1 = 0; y0 = 0; y1 = 4; reset = 0; repeat(20) @(posedge clk);
		$stop;
	end
	
endmodule 

