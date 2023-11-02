module top (
    input        sysclk,
    input  [3:0] btn,
    input [1:0] sw,
    output [3:0] led,
    output led4_b,
    output led4_g,
    output led4_r
);

wire [3:0] pulse;
wire [1:0] bought_type;

genvar i;
generate
    for (i = 0; i < 4; i = i + 1) begin : BTN_FILTER_INST
        BtnPulse u_BtnPulse(
            .clk(sysclk),
            .btn_in(btn[i]),
            .pulse(pulse[i])
        );
    end
endgenerate

CoinCntr u_CoinCntr(
    .clk(sysclk),
    .clr(pulse[3]),
    .buy(pulse[2]),
    .buy_type(sw),
    .coin_type(pulse[1:0]),
    .money_left(led),
    .bought_type(bought_type)
);

BoughtTypeDisplay u_BoughtTypeDisplay (
    .clk(sysclk),
    .bought_type(bought_type),
    .r(led4_r),
    .g(led4_g),
    .b(led4_b)
);

endmodule