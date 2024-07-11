module shifter (fallen_pieces, row, enabled, new_grid);

input fallen_pieces, row, enabled;
output new_grid;

wire [48:0] fallen_pieces;
wire [2:0] row;
wire enabled;

reg [48:0] new_grid;
//reg [55:0] temp_grid;


always @(*) begin
  if (enabled) begin
    case (row)  
      0: begin
        new_grid = {fallen_pieces[48:7], 7'b0000000};
      end
      1: begin
        new_grid = {fallen_pieces[48:14], fallen_pieces[6:0], 7'b0000000};
      end
      2: begin
        new_grid = {fallen_pieces[48:21], fallen_pieces[13:0], 7'b0000000};
      end
      3: begin
        new_grid = {fallen_pieces[48:28], fallen_pieces[20:0], 7'b0000000};
      end
      4: begin
        new_grid = {fallen_pieces[48:35], fallen_pieces[27:0], 7'b0000000};
      end
      5: begin
        new_grid = {fallen_pieces[48:42], fallen_pieces[34:0], 7'b0000000};
      end
      6: begin
        new_grid = {fallen_pieces[41:0], 7'b0000000};
      end
    endcase      
  end
 else begin
   new_grid = fallen_pieces;
 end     
end  

endmodule