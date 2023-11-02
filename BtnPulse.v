module BtnPulse (
    input clk,
    input btn_in,
    output pulse
);

(*ASYNC_REG="TRUE"*) reg [1:0] btn_sync;
reg [16:0] cntr;
reg [1:0] btn_filtered;
reg pulse_reg;

initial begin
    btn_sync <= 2'b0;
    cntr <= 17'b0;
    btn_filtered <= 2'b0;
    pulse_reg <= 1'b0;
end;

always@(posedge clk) begin
    btn_sync <= {btn_sync[0], btn_in};
end

always@(posedge clk) begin
    if (~(btn_sync[1])) begin
        cntr <= 17'b0;
    end else begin
        if (cntr < 17'd125000) begin
            cntr <= cntr + 1'b1;
        end
    end
end

always@(posedge clk) begin
    btn_filtered <= {btn_filtered[0], cntr == 17'd125000};
end

always@(posedge clk) begin
    pulse_reg <= (~(btn_filtered[1])) & (btn_filtered[0]);
end

assign pulse = pulse_reg;

endmodule