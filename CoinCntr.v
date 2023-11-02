module CoinCntr (
    input clk,
    input clr,
    input buy,
    input [1:0] buy_type,
    input [1:0] coin_type,
    output [3:0] money_left,
    output reg [1:0] bought_type
);

reg [4:0] money_cntr;

reg [3:0] buy_cost;
reg [3:0] coin_value;
reg [4:0] money_next_intended;
reg [4:0] money_next;

reg [1:0] to_buy;

initial begin
    // give the register the initial value `0`
    money_cntr <= 5'b0;
end

// --- Modify the codes below
// add wires, reg, always if needed

always@(buy, buy_type, money_cntr) begin
    // give `buy_cost` a default value,
    buy_cost = 4'b0000;
    if (buy) begin
//        if (money_cntr >= 4'b1010) begin
//            // ... and deal with the only special case
//            buy_cost = 4'b1010;
//        end
        case (buy_type)
            2'b01: buy_cost = (money_cntr >= 5) ? 5 : 0;
            2'b10: buy_cost = (money_cntr >= 10) ? 10 : 0;
            2'b11: buy_cost = (money_cntr >= 15) ? 15 : 0;
            default: buy_cost = 0;
        endcase
    end
    to_buy = (buy_cost == 0) ? 0 : buy_type;
end

// --- Modify the codes above

always@(coin_type) begin
    if (coin_type == 2'b01) begin
        coin_value = 4'b0001;
    end else if (coin_type == 2'b10) begin
        coin_value = 4'b0011;
    end else if (coin_type == 2'b11) begin
        coin_value = 4'b1010;
    end else begin
        coin_value = 4'b0000;
    end
end

always@(coin_value, buy_cost, money_cntr) begin
    money_next_intended = money_cntr - buy_cost + coin_value;
end

always@(money_next_intended) begin
    if (money_next_intended >= 4'b1111) begin
        money_next = 4'b1111;
    end else begin
        money_next = money_next_intended;
    end
end

always@(posedge clk) begin
    if (clr) begin
        money_cntr <= 5'b0;
    end else begin
        money_cntr <= money_next;
    end
    bought_type = to_buy;
end

assign money_left = money_cntr[3:0];

endmodule