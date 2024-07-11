

module visual(
    input wire [48:0] fallen_pieces,
    input wire [5:0] blk_1,
    input wire [5:0] blk_2,
    input wire [5:0] blk_3,
    input wire [5:0] blk_4,
    output reg [6:0] row_0,
    output reg [6:0] row_1,
    output reg [6:0] row_2,
    output reg [6:0] row_3,
    output reg [6:0] row_4,
    output reg [6:0] row_5,
    output reg [6:0] row_6
    );

    reg [48:0] display_pieces;

    always @ (*) begin
	display_pieces = fallen_pieces;
  display_pieces[blk_1] = 1;
	display_pieces[blk_2] = 1;
	display_pieces[blk_3] = 1;
	display_pieces[blk_4] = 1;

	row_0 = display_pieces[7:0];
	row_1 = display_pieces[(2*7)-1:7];
	row_2 = display_pieces[(3*7)-1:(2*7)];
	row_3 = display_pieces[(4*7)-1:(3*7)];
	row_4 = display_pieces[(5*7)-1:(4*7)];
	row_5 = display_pieces[(6*7)-1:(5*7)];
	row_6 = display_pieces[(7*7)-1:(6*7)];
end

endmodule
