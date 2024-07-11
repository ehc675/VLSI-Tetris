module calc_test_pos_rot(btn_left_en, btn_right_en, btn_rotate_en, btn_down_en, cur_pos_x, cur_pos_y, cur_rot, test_pos_x, test_pos_y, test_rot);

input btn_left_en, btn_right_en, btn_rotate_en, btn_down_en, cur_pos_x, cur_pos_y, cur_rot;
output test_pos_x, test_pos_y, test_rot;

//mode, game_clk_rst, game_clk, btn_drop_en - MODDED OUT INPUTS


wire btn_left_en, btn_right_en, btn_rotate_en, btn_down_en;
wire [1:0] cur_rot;
//wire [2:0] mode;
wire [3:0] cur_pos_x, cur_pos_y;

reg [1:0] test_rot;
reg [3:0] test_pos_x, test_pos_y;

parameter MODE_PLAY = 3'b000, MODE_DROP = 3'b001;


always @ (*) begin
//    if (mode == MODE_PLAY) begin
//        if (game_clk) begin
//            test_pos_x = cur_pos_x;
//            test_pos_y = cur_pos_y + 1; 
//            test_rot = cur_rot;
//        end 
        if (btn_left_en) begin
            if (cur_pos_x == 6) begin
              test_pos_x = cur_pos_x;
              test_pos_y = cur_pos_y + 1;             
            end
            else begin                                             
              test_pos_x = cur_pos_x + 1; 
              test_pos_y = cur_pos_y; 
              test_rot = cur_rot;
            end                
        end 
        else if (btn_right_en) begin
            if (cur_pos_x == 0) begin
              test_pos_x = cur_pos_x;
              test_pos_y = cur_pos_y + 1;
            end
            else begin 
              test_pos_x = cur_pos_x - 1; 
              test_pos_y = cur_pos_y; 
              test_rot = cur_rot;
            end  
        end 
        else if (btn_rotate_en) begin
            test_pos_x = cur_pos_x;
            test_pos_y = cur_pos_y;
            test_rot = cur_rot + 1; 
        end 
        else if (btn_down_en) begin
            test_pos_x = cur_pos_x;
            test_pos_y = cur_pos_y + 1;
            test_rot = cur_rot;
        end 
//       else if (btn_drop_en) begin
//            test_pos_x = cur_pos_x;
//            test_pos_y = cur_pos_y;
//            test_rot = cur_rot;
//        end 
        else begin
            test_pos_x = cur_pos_x;
            test_pos_y = cur_pos_y + 1;
            test_rot = cur_rot;
        end
    end 
//    else if (mode == MODE_DROP) begin
//        if (game_clk_rst) begin
//            test_pos_x = cur_pos_x;
//            test_pos_y = cur_pos_y;
//            test_rot = cur_rot;
//        end 
//        else begin
//            test_pos_x = cur_pos_x;
//            test_pos_y = cur_pos_y + 1; 
//            test_rot = cur_rot;
//        end
//    end else begin
//        test_pos_x = cur_pos_x;
//        test_pos_y = cur_pos_y;
//        test_rot = cur_rot;
//    end
//end

endmodule