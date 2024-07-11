module main_FSM (clka, clkb, restart, play_sig, next_play_sig, make_sig, clear_sig, over_sig, btn_left_en, btn_right_en, btn_rotate_en, btn_down_en, cur_pos_x_in,
                 cur_pos_y_in, cur_rot_in, test_out_sig, new_block_test_out_sig, row_clear_out_sig, game_over_out_sig, move_out_sig,
                 test_width, test_height, test_blk_1, test_blk_2, test_blk_3, test_blk_4, state);

input   clka, clkb, restart, play_sig, next_play_sig, make_sig, clear_sig, over_sig, btn_left_en, btn_right_en, btn_rotate_en, btn_down_en,
        cur_pos_x_in, cur_pos_y_in, cur_rot_in;

output  test_out_sig, new_block_test_out_sig, row_clear_out_sig, game_over_out_sig, move_out_sig, test_width,
        test_height, test_blk_1, test_blk_2, test_blk_3, test_blk_4, state;

wire clka, clkb, restart, play_sig, next_play_sig, make_sig, clear_sig, over_sig, btn_left_en, btn_right_en, btn_rotate_en, btn_down_en;
wire [1:0] cur_rot_in;
wire [3:0] cur_pos_x_in, cur_pos_y_in;
wire [2:0] test_width, test_height;
wire [5:0] test_blk_1, test_blk_2, test_blk_3, test_blk_4;

reg  test_out_sig, new_block_test_out_sig, row_clear_out_sig, game_over_out_sig;
reg  [1:0] move_out_sig;

//internal variables
wire [1:0] test_rot;
wire [2:0] rando;
wire [3:0] test_pos_x, test_pos_y;

reg pass_left, pass_right, pass_down, pass_rot, int_make_block;
reg [1:0] int_rot;
reg [2:0] int_piece;
reg [3:0] int_pos_x, int_pos_y;

parameter SIZE = 3;
parameter rst  = 3'b000, play = 3'b001, check = 3'b010, clear = 3'b011, over = 3'b100;

reg   [SIZE-1:0]          state;    	// Initial FSM state reg and then after
wire  [SIZE-1:0]          temp_state; 	// Internal wire for output of function
reg   [SIZE-1:0]          next_state; 	// Temporary reg to hold next state to

assign temp_state = fsm_function(state, play_sig, next_play_sig, make_sig, clear_sig, over_sig);

function [SIZE-1:0] fsm_function;
input  [SIZE-1:0] state;
input play_sig;
input next_play_sig;
input make_sig;
input clear_sig;
input over_sig;

case(state)
   rst: begin
          if (play_sig) begin
            fsm_function = play;
            int_make_block = 1;
          end
          else begin
            fsm_function = rst;
            int_make_block = 0;
          end
        end
   play: begin
            fsm_function = check;
         end
   check: begin
            if (over_sig) begin
                fsm_function = over;
                int_make_block = 0;
            end
            else if (clear_sig) begin
                fsm_function = clear;
                int_make_block = 0;
            end
            else if (next_play_sig) begin
                if (make_sig) begin
                    int_make_block = 1;
                end
                else begin
                    int_make_block = 0;
                end
            fsm_function = play;
            end
         end
   clear: begin
           if (clear_sig) begin
             fsm_function = clear;
           end
           else begin
             fsm_function = play;
             int_make_block = 1;
           end
         end
   over: begin
           fsm_function = rst;
         end
   default: fsm_function = rst;
  endcase
endfunction

//----------Seq Logic-----------------------------
always @ (posedge clka)
begin : FSM_SEQ
  if (restart == 1'b1) begin
    next_state <= rst;
  end else begin
    next_state <= temp_state;
  end
end

//----------Output Logic-------------
always @ (posedge clkb)
begin : OUTPUT_LOGIC
    case(next_state)
   rst: begin
          int_pos_x = 0;
          int_pos_y = 0;
          int_rot = 0;
          pass_left = 0;
          pass_right = 0;
          pass_down = 0;
          pass_rot = 0;
          test_out_sig = 0;
          row_clear_out_sig = 0;
          game_over_out_sig = 0;
          new_block_test_out_sig = 0;
          move_out_sig = 2'b11;
        end
   play: begin
           if (int_make_block) begin
               int_piece = rando;
               int_pos_x = 3;
               int_pos_y = 15;
               int_rot = 0;
               pass_left = 0;
               pass_right = 0;
               pass_down = 0;
               pass_rot = 0;
               new_block_test_out_sig = 1;
               move_out_sig = 2'b11;
           end
           else begin
               int_pos_x = cur_pos_x_in;
               int_pos_y = cur_pos_y_in;
               int_rot = cur_rot_in;
               pass_left = btn_left_en;
               pass_right = btn_right_en;
               pass_down = btn_down_en;
               pass_rot = btn_rotate_en;
               new_block_test_out_sig = 0;
               if (btn_left_en) begin
                 move_out_sig = 2'b00;
               end
               else if (btn_right_en) begin
                 move_out_sig = 2'b01;
               end
               else if (btn_rotate_en) begin
                 move_out_sig = 2'b10;
               end
               else begin
                 move_out_sig = 2'b11;
               end
           end
           test_out_sig = 1;
           row_clear_out_sig = 0;
         end
   check: begin
            test_out_sig = 0;
          end
   clear: begin
            row_clear_out_sig = 1;
          end
   over: begin
            game_over_out_sig = 1;
         end
  endcase
  state = next_state;
end // End Of Block OUTPUT_LOGIC

randomizer random_block (
  .clk(clka),
  .restart(restart),
  .random(rando));

calc_test_pos_rot test_coords (
  .btn_left_en(pass_left),
  .btn_right_en(pass_right),
  .btn_rotate_en(pass_rot),
  .btn_down_en(pass_down),
  .cur_pos_x(int_pos_x),
  .cur_pos_y(int_pos_y),
  .cur_rot(int_rot),
  .test_pos_x(test_pos_x),
  .test_pos_y(test_pos_y),
  .test_rot(test_rot));

calc_cur_blk make_block (
  .piece(int_piece),
  .pos_x(test_pos_x),
  .pos_y(test_pos_y),
  .rot(test_rot),
  .blk_1(test_blk_1),
  .blk_2(test_blk_2),
  .blk_3(test_blk_3),
  .blk_4(test_blk_4),
  .width(test_width),
  .height(test_height));

endmodule // End of Module main_FSM