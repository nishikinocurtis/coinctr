module BoughtTypeDisplay (
    input clk,
    input [1:0] bought_type,
    output reg r,
    output reg g,
    output reg b
);

reg [1:0] bought_type_reg;

initial begin
    bought_type_reg <= 2'b00;
end

always@(posedge clk) begin
    if (bought_type != 2'b00) begin
        bought_type_reg <= bought_type;
    end else begin
        bought_type_reg <= bought_type_reg;
    end
end

initial begin
    r <= 1'b1;
    g <= 1'b1;
    b <= 1'b1;
end

always@(posedge clk) begin
    if (bought_type_reg == 2'b00) begin
        r <= r;
    end else begin
        if (bought_type_reg == 2'b01) begin
            r <= 1'b1;
        end else begin
            r <= 1'b0;
        end
    end
end

always@(posedge clk) begin
    if (bought_type_reg == 2'b00) begin
        g <= g;
    end else begin
        if (bought_type_reg == 2'b10) begin
            g <= 1'b1;
        end else begin
            g <= 1'b0;
        end
    end
end

always@(posedge clk) begin
    if (bought_type_reg == 2'b00) begin
        b <= b;
    end else begin
        if (bought_type_reg == 2'b11) begin
            b <= 1'b1;
        end else begin
            b <= 1'b0;
        end
    end
end

endmodule