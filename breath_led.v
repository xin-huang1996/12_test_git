
module	breath_led(
	input	clk,
	input	rst_n,
	output	led
);

reg	[15:0]	period_cnt;
reg	[15:0]	duty_cycle;
reg			inc_dec_flag;	// 0 : up  1: down

assign led = (period_cnt >= duty_cycle) ? 1'b1 : 1'b0;

always@(posedge	clk	or negedge	rst_n)begin
	if(!rst_n)
		period_cnt <= 16'd0;
	else if(period_cnt == 16'd50000)
		period_cnt <= 16'd0;
	else
		period_cnt <= period_cnt + 1'b1;
end

always@(posedge	clk	or negedge rst_n)begin
	if(!rst_n)begin
		duty_cycle <= 16'd0;
		inc_dec_flag <= 1'b0;
	end

	else begin
		if(period_cnt == 16'd50000)begin
			if(inc_dec_flag == 1'b0)begin
				if(duty_cycle == 16'd5000)
					inc_dec_flag <= 1'b1;
					else begin
						duty_cycle <= duty_cycle + 16'd25;
					end
			end
			else begin
				if(duty_cycle == 16'd0)
					inc_dec_flag <= 1'd0;
				else begin
					duty_cycle <= duty_cycle - 16'd25;
				end
			end
		end
	end
end
endmodule

