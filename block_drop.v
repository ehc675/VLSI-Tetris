module calc_cur_blk(piece, pos_x, pos_y, rot, blk_1, blk_2, blk_3, blk_4, width, height);

input piece, pos_x, pos_y, rot;
output blk_1, blk_2, blk_3, blk_4, width, height;

wire [1:0] rot;
wire [2:0] piece;
wire [3:0] pos_x, pos_y;
reg [2:0] width, height;
reg [5:0] blk_1, blk_2, blk_3, blk_4;

parameter EMPTY_BLOCK = 3'b000, I_BLOCK = 3'b001, O_BLOCK = 3'b010, T_BLOCK = 3'b011;
parameter S_BLOCK = 3'b100, Z_BLOCK = 3'b101, J_BLOCK = 3'b110, L_BLOCK = 3'b111;


always @ (*) begin
  case (piece)
    EMPTY_BLOCK: begin
      blk_1 = 8'b11111111;
      blk_2 = 8'b11111111;
      blk_3 = 8'b11111111;
      blk_4 = 8'b11111111;
      width = 0;
      height = 0;
    end  
    I_BLOCK: begin
      if (rot == 0 || rot == 2) begin
        blk_1 = (pos_y * 7) + pos_x;
        blk_2 = (pos_y * 7) + pos_x + 1;
        blk_3 = (pos_y * 7) + pos_x + 2;
        blk_4 = (pos_y * 7) + pos_x + 3;
        width = 4;
        height = 1;
      end 
      else begin
        blk_1 = (pos_y * 7) + pos_x;
        blk_2 = ((pos_y + 1) * 7) + pos_x;
        blk_3 = ((pos_y + 2) * 7) + pos_x;
        blk_4 = ((pos_y + 3) * 7) + pos_x;
        width = 1;
        height = 4;
      end          
    end
    O_BLOCK: begin
        blk_1 = (pos_y * 7) + pos_x;
        blk_2 = (pos_y * 7) + pos_x + 1;
        blk_3 = ((pos_y + 1) * 7) + pos_x;
        blk_4 = ((pos_y + 1) * 7) + pos_x + 1;
        width = 2;
        height = 2;
    end
    T_BLOCK: begin
      case (rot)
        0: begin
          blk_1 = (pos_y * 7) + pos_x + 1;
          blk_2 = ((pos_y + 1) * 7) + pos_x;
          blk_3 = ((pos_y + 1) * 7) + pos_x + 1;
          blk_4 = ((pos_y + 1) * 7) + pos_x + 2;
          width = 3;
          height = 2;
        end
        1: begin
          blk_1 = (pos_y * 7) + pos_x;
          blk_2 = ((pos_y + 1) * 7) + pos_x;
          blk_3 = ((pos_y + 2) * 7) + pos_x;
          blk_4 = ((pos_y + 1) * 7) + pos_x + 1;
          width = 2;
          height = 3;
        end
        2: begin
          blk_1 = (pos_y * 7) + pos_x;
          blk_2 = (pos_y * 7) + pos_x + 1;
          blk_3 = (pos_y * 7) + pos_x + 2;
          blk_4 = ((pos_y + 1) * 7) + pos_x + 1;
          width = 3;
          height = 2;
        end
        3: begin
          blk_1 = (pos_y * 7) + pos_x + 1;
          blk_2 = ((pos_y + 1) * 7) + pos_x + 1;
          blk_3 = ((pos_y + 2) * 7) + pos_x + 1;
          blk_4 = ((pos_y + 1) * 7) + pos_x;
          width = 2;
          height = 3;
        end      
      endcase
    end   
    S_BLOCK: begin
      if (rot == 0 || rot == 2) begin
        blk_1 = (pos_y * 7) + pos_x + 1;
        blk_2 = (pos_y * 7) + pos_x + 2;
        blk_3 = ((pos_y + 1) * 7) + pos_x;
        blk_4 = ((pos_y + 1) * 7) + pos_x + 1;
        width = 3;
        height = 2;
      end 
      else begin
        blk_1 = (pos_y * 7) + pos_x;
        blk_2 = ((pos_y + 1) * 7) + pos_x;
        blk_3 = ((pos_y + 1) * 7) + pos_x + 1;
        blk_4 = ((pos_y + 2) * 7) + pos_x + 1;
        width = 2;
        height = 3;
      end
    end    
    Z_BLOCK: begin
        if (rot == 0 || rot == 2) begin
          blk_1 = (pos_y * 7) + pos_x;
          blk_2 = (pos_y * 7) + pos_x + 1;
          blk_3 = ((pos_y + 1) * 7) + pos_x + 1;
          blk_4 = ((pos_y + 1) * 7) + pos_x + 2;
          width = 3;
          height = 2;
        end 
        else begin
          blk_1 = (pos_y * 7) + pos_x + 1;
          blk_2 = ((pos_y + 1) * 7) + pos_x;
          blk_3 = ((pos_y + 2) * 7) + pos_x;
          blk_4 = ((pos_y + 1) * 7) + pos_x + 1;
          width = 2;
          height = 3;
        end
    end    
    J_BLOCK: begin
        case (rot)
            3: begin
              blk_1 = (pos_y * 7) + pos_x + 1;
              blk_2 = ((pos_y + 1) * 7) + pos_x + 1;
              blk_3 = ((pos_y + 2) * 7) + pos_x + 1;
              blk_4 = ((pos_y + 2) * 7) + pos_x;
              width = 2;
              height = 3;
            end
            0: begin
              blk_1 = (pos_y * 7) + pos_x;
              blk_2 = ((pos_y + 1) * 7) + pos_x;
              blk_3 = ((pos_y + 1) * 7) + pos_x + 1;
              blk_4 = ((pos_y + 1) * 7) + pos_x + 2;
              width = 3;
              height = 2;
            end
            1: begin
              blk_1 = (pos_y * 7) + pos_x;
              blk_2 = ((pos_y + 1) * 7) + pos_x;
              blk_3 = ((pos_y + 2) * 7) + pos_x;
              blk_4 = (pos_y * 7) + pos_x + 1;
              width = 2;
              height = 3;
            end
            2: begin
              blk_1 = (pos_y * 7) + pos_x;
              blk_2 = (pos_y * 7) + pos_x + 1;
              blk_3 = (pos_y * 7) + pos_x + 2;
              blk_4 = ((pos_y + 1) * 7) + pos_x + 2;
              width = 3;
              height = 2;
            end
        endcase
    end       
    L_BLOCK: begin
        case (rot)
            3: begin
              blk_1 = (pos_y * 7) + pos_x;
              blk_2 = ((pos_y + 1) * 7) + pos_x;
              blk_3 = ((pos_y + 2) * 7) + pos_x;
              blk_4 = ((pos_y + 2) * 7) + pos_x + 1;
              width = 2;
              height = 3;
            end
            0: begin
              blk_1 = ((pos_y + 1) * 7) + pos_x;
              blk_2 = (pos_y * 7) + pos_x;
              blk_3 = (pos_y * 7) + pos_x + 1;
              blk_4 = (pos_y * 7) + pos_x + 2;
              width = 3;
              height = 2;
            end
            1: begin
              blk_1 = (pos_y * 7) + pos_x + 1;
              blk_2 = ((pos_y + 1) * 7) + pos_x + 1;
              blk_3 = ((pos_y + 2) * 7) + pos_x + 1;
              blk_4 = (pos_y * 7) + pos_x;
              width = 2;
              height = 3;
            end
            2: begin
              blk_1 = ((pos_y + 1) * 7) + pos_x;
              blk_2 = ((pos_y + 1) * 7) + pos_x + 1;
              blk_3 = ((pos_y + 1) * 7) + pos_x + 2;
              blk_4 = (pos_y * 7) + pos_x + 2;
              width = 3;
              height = 2;
            end
        endcase
    end        
  endcase      
end

endmodule        
        
        
        
        