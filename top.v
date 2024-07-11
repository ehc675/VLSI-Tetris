module top_t (clka, clkb, restart, play_sig, btn_left_en, btn_right_en, btn_rotate_en, btn_down_en,
           vis_0, vis_1, vis_2, vis_3, vis_4, vis_5, vis_6, state);

input clka, clkb, restart, play_sig, btn_left_en, btn_right_en, btn_rotate_en, btn_down_en;

output vis_0, vis_1, vis_2, vis_3, vis_4, vis_5, vis_6, state;

wire clka, clkb, restart, play_sig, next_play_sig, make_sig, btn_left_en, btn_right_en, btn_rotate_en, btn_down_en, clear_out_sig, over_out_sig, game_over_out_sig, test_out_sig, new_block_test_out_sig, row_clear_out_sig;
wire [1:0] rot_out, move_out_sig;
wire [2:0] test_width, test_height, state;
wire [3:0] x_out, y_out;
wire [5:0] test_blk_1, test_blk_2, test_blk_3, test_blk_4;
wire [6:0] vis_0, vis_1, vis_2, vis_3, vis_4, vis_5, vis_6;

main_FSM top_m (.clka (clka), 
              .clkb (clkb), 
              .restart (restart), 
              .play_sig (play_sig), 
              .next_play_sig (next_play_sig),
              .make_sig(make_sig),
              .clear_sig (clear_out_sig), 
              .over_sig (over_out_sig), 
              .btn_left_en (btn_left_en), 
              .btn_right_en (btn_right_en), 
              .btn_rotate_en (btn_rotate_en), 
              .btn_down_en (btn_down_en), 
              .cur_pos_x_in (x_out),
              .cur_pos_y_in (y_out), 
              .cur_rot_in (rot_out), 
              .test_out_sig (test_out_sig), 
              .new_block_test_out_sig (new_block_test_out_sig), 
              .row_clear_out_sig (row_clear_out_sig), 
              .game_over_out_sig (game_over_out_sig), 
              .move_out_sig (move_out_sig),
              .test_width (test_width), 
              .test_height (test_height), 
              .test_blk_1 (test_blk_1), 
              .test_blk_2 (test_blk_2), 
              .test_blk_3 (test_blk_3), 
              .test_blk_4 (test_blk_4), 
              .state (state));

dp top_d (.clka (clka),
        .clkb (clkb),
        .restart (restart),
        .test_blk_1 (test_blk_1),
        .test_blk_2 (test_blk_2),
        .test_blk_3 (test_blk_3),
        .test_blk_4 (test_blk_4),
        .test_width (test_width),
        .test_height (test_height),
        .test_in_sig (test_out_sig),
        .new_block_test_in_sig (new_block_test_out_sig),
        .move_in_sig (move_out_sig),
        .row_clear_in_sig (row_clear_out_sig),
        .next_play_sig (next_play_sig),
        .make_sig (make_sig),
        .clear_out_sig (clear_out_sig),
        .over_out_sig (over_out_sig),
        .vis_0 (vis_0),
        .vis_1 (vis_1),
        .vis_2 (vis_2),
        .vis_3 (vis_3),
        .vis_4 (vis_4),
        .vis_5 (vis_5),
        .vis_6 (vis_6),
        .rot_out (rot_out),
        .x_out (x_out),
        .y_out (y_out));






endmodule