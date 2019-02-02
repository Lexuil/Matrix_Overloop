/* Machine-generated using Migen */
module top(
	output user_led,
	input clk100
);

reg [16:0] __main___counter = 17'd0;
reg __main___en = 1'd1;
wire sys_clk;
wire sys_rst;
wire por_clk;
reg platform_int_rst = 1'd1;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign user_led = __main___en;
assign sys_clk = clk100;
assign por_clk = clk100;
assign sys_rst = platform_int_rst;

always @(posedge por_clk) begin
	platform_int_rst <= 1'd0;
end

always @(posedge sys_clk) begin
	if ((__main___counter == 10'd600)) begin
		__main___counter <= 1'd0;
		__main___en <= (~__main___en);
	end else begin
		__main___counter <= (__main___counter + 1'd1);
	end
	if (sys_rst) begin
		__main___counter <= 17'd0;
		__main___en <= 1'd1;
	end
end

endmodule
