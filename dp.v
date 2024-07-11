module dp (clka, clkb, restart, test_blk_1, test_blk_2, test_blk_3, test_blk_4, test_width, test_height, test_in_sig,
           new_block_test_in_sig, move_in_sig, row_clear_in_sig,
           next_play_sig, make_sig, clear_out_sig, over_out_sig, vis_0, vis_1, vis_2, vis_3, vis_4, vis_5, vis_6, rot_out, x_out, y_out);


input clka, clkb, restart, test_blk_1, test_blk_2, test_blk_3, test_blk_4, test_width, test_height, test_in_sig, new_block_test_in_sig, move_in_sig,
      row_clear_in_sig;

output next_play_sig, make_sig, clear_out_sig, over_out_sig, vis_0, vis_1, vis_2, vis_3, vis_4, vis_5, vis_6, rot_out, x_out, y_out;

wire  clka, clkb, restart, test_in_sig, new_block_test_in_sig, row_clear_in_sig;
wire  [1:0] move_in_sig;
wire  [2:0] test_width, test_height;
wire  [5:0] test_blk_1, test_blk_2, test_blk_3, test_blk_4;

reg next_play_sig, make_sig, clear_out_sig, over_out_sig;
reg [1:0] rot_out;
reg [3:0] x_out, y_out;
wire [6:0] vis_0, vis_1, vis_2, vis_3, vis_4, vis_5, vis_6;

parameter left  = 2'b00, right = 2'b01, rot = 2'b10, down = 2'b11;

//internal
wire [48:0] current_board_shift;
reg intersects, intersects_below, last_row, add_to_board, buff, en_0, en_1, en_2, en_3, en_4, en_5, en_6;
reg [1:0] cur_rot;
reg [2:0] cur_row, cur_width, cur_height;
reg [3:0] cur_pos_x, cur_pos_y;
reg [5:0] blk_1, blk_2, blk_3, blk_4;
reg [48:0] current_board;

//always @ (*)
//begin
////    intersects = current_board[test_blk_1] || current_board[test_blk_2] || current_board[test_blk_3] || current_board[test_blk_4];
////    intersects_below = current_board[blk_1 + 7] || current_board[blk_2 + 7] || current_board[blk_3 + 7] || current_board[blk_4 + 7];
////    last_row = test_blk_1 > 41 || test_blk_2 > 41 || test_blk_3 > 41 || test_blk_4 > 41;
////    buff = (test_blk_1 > 13 || test_blk_2 > 13 || test_blk_3 > 13 || test_blk_4 > 13) && new_block_test_in_sig;
////
////    en_0 = &current_board[0+: 7];
////    en_1 = &current_board[7+: 7];
////    en_2 = &current_board[14+: 7];
////    en_3 = &current_board[21+: 7];
////    en_4 = &current_board[28+: 7];
////    en_5 = &current_board[35+: 7];
////    en_6 = &current_board[42+: 7];
////
////    clear_out_sig = en_0 || en_1 || en_2 || en_3 || en_4 || en_5 || en_6;
//end

always @ (posedge clkb)
begin
    intersects = current_board[test_blk_1] || current_board[test_blk_2] || current_board[test_blk_3] || current_board[test_blk_4];
    intersects_below = current_board[blk_1 + 7] || current_board[blk_2 + 7] || current_board[blk_3 + 7] || current_board[blk_4 + 7];
    last_row = test_blk_1 > 41 || test_blk_2 > 41 || test_blk_3 > 41 || test_blk_4 > 41;
    buff = (test_blk_1 > 13 || test_blk_2 > 13 || test_blk_3 > 13 || test_blk_4 > 13) && new_block_test_in_sig;

    en_0 = &current_board[0+: 7];
    en_1 = &current_board[7+: 7];
    en_2 = &current_board[14+: 7];
    en_3 = &current_board[21+: 7];
    en_4 = &current_board[28+: 7];
    en_5 = &current_board[35+: 7];
    en_6 = &current_board[42+: 7];

    clear_out_sig = en_0 || en_1 || en_2 || en_3 || en_4 || en_5 || en_6;

    if (restart) begin
      cur_pos_x = 0;
      cur_pos_y = 0;
      cur_rot = 0;
      cur_width = 0;
      cur_height = 0;
      blk_1 = 0;
      blk_2 = 6;
      blk_3 = 42;
      blk_4 = 48;
      over_out_sig = 0;
      add_to_board = 0;
    end

//    else if (row_clear_in_sig) begin
//      current_board = current_board_shift;
//      if (cur_row == 6) begin
//        cur_row = 0;
//      end
//      else begin
//        cur_row = cur_row + 1;
//      end
//      blk_1 = 0;
//      blk_2 = 6;
//      blk_3 = 42;
//      blk_4 = 48;
//    end

    else if (test_in_sig) begin

      if (new_block_test_in_sig) begin
        cur_rot = 0;
        cur_pos_x = 3;
        cur_pos_y = 0;
        cur_width = test_width;
        cur_height = test_height;
        add_to_board = 0;
      end

      if (intersects && new_block_test_in_sig) begin
        over_out_sig = 1;
      end

      if (intersects || last_row) begin
        add_to_board = 1;
      end

      case (move_in_sig)
        right: begin
          if (cur_pos_x > 0 && !intersects) begin
            cur_pos_x = cur_pos_x - 1;
            blk_1 = test_blk_1;
            blk_2 = test_blk_2;
            blk_3 = test_blk_3;
            blk_4 = test_blk_4;
          end
          else if (!intersects_below) begin
            cur_pos_y = cur_pos_y + 1;
            blk_1 = blk_1 + 7;
            blk_2 = blk_2 + 7;
            blk_3 = blk_3 + 7;
            blk_4 = blk_4 + 7;
          end
          else begin
            add_to_board = 1;
          end
        end

        left: begin
          if (cur_pos_x + cur_width < 7 && !intersects) begin
            cur_pos_x = cur_pos_x + 1;
            blk_1 = test_blk_1;
            blk_2 = test_blk_2;
            blk_3 = test_blk_3;
            blk_4 = test_blk_4;
          end
          else if (!intersects_below) begin
            cur_pos_y = cur_pos_y + 1;
            blk_1 = blk_1 + 7;
            blk_2 = blk_2 + 7;
            blk_3 = blk_3 + 7;
            blk_4 = blk_4 + 7;
          end
          else begin
            add_to_board = 1;
          end
        end

        rot: begin
          if (cur_pos_x + test_width <= 7 && cur_pos_y + test_height <= 7 && !intersects) begin
            cur_rot = cur_rot + 1;
            cur_width = cur_height;
            cur_height = cur_width;
            blk_1 = test_blk_1;
            blk_2 = test_blk_2;
            blk_3 = test_blk_3;
            blk_4 = test_blk_4;
          end
          else if (!intersects_below) begin
            cur_pos_y = cur_pos_y + 1;
            blk_1 = blk_1 + 7;
            blk_2 = blk_2 + 7;
            blk_3 = blk_3 + 7;
            blk_4 = blk_4 + 7;
          end
          else begin
            add_to_board = 1;
          end
        end

        down: begin
          if (cur_pos_y + cur_height < 7 && !intersects) begin
//            if (last_row || intersects) begin
//                add_to_board = 1;
//            end
            if (new_block_test_in_sig) begin
              cur_pos_y = cur_pos_y;
            end
            else begin
                cur_pos_y = cur_pos_y + 1;
            end
            blk_1 = test_blk_1;
            blk_2 = test_blk_2;
            blk_3 = test_blk_3;
            blk_4 = test_blk_4;
          end
          else begin
            add_to_board = 1;
          end
        end
      endcase
    end
end

always @ (posedge clka)
begin
//  new_board = current_board;

  if (restart) begin
    current_board = 0;
    cur_row = 0;
    rot_out = 0;
    x_out = 0;
    y_out = 0;
  end

  else if (row_clear_in_sig) begin
    current_board = current_board_shift;
    if (cur_row == 6) begin
      cur_row = 0;
    end
    else begin
      cur_row = cur_row + 1;
    end
  end

  else if (add_to_board && !buff) begin
    current_board[blk_1] = 1;
    current_board[blk_2] = 1;
    current_board[blk_3] = 1;
    current_board[blk_4] = 1;
    make_sig = 1;
//    add_to_board = 0;
  end

  else if (buff) begin
    make_sig = 1;
//    add_to_board = 0;
  end

  else begin
    make_sig = 0;
  end

//  clear_out_sig = en_0 || en_1 || en_2 || en_3 || en_4 || en_5 || en_6 || en_7;

  next_play_sig = !clear_out_sig && !over_out_sig;

  rot_out = cur_rot;
  x_out = cur_pos_x;
  y_out = cur_pos_y;

end

  shifter clear (
    .fallen_pieces(current_board),
    .row(cur_row),
    .enabled(&current_board[cur_row * 7+: 7]),
    .new_grid(current_board_shift));

  visual vis (
    .fallen_pieces(current_board),
    .blk_1(blk_1),
    .blk_2(blk_2),
    .blk_3(blk_3),
    .blk_4(blk_4),
    .row_0(vis_0),
    .row_1(vis_1),
    .row_2(vis_2),
    .row_3(vis_3),
    .row_4(vis_4),
    .row_5(vis_5),
    .row_6(vis_6));

endmodule //End Of Module dp  datapath