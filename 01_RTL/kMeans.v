module kMeans(
  clk,
  rst_n,
  in_valid,
  in_data,
  out_valid,
  out_data
);

input               clk;
input               rst_n;
input               in_valid;
input       [15:0]  in_data;
output reg          out_valid;
output reg  [15:0]  out_data;

parameter CLUSTER_SIZE  = 'd4,
          DATA_SIZE     = 'd4096;

parameter ST_IDLE       = 0,
          ST_INIT_INPUT = 1,
          ST_DATA_INPUT = 2,
          ST_SYNC       = 3,// only used once to sync input data
          ST_GROUP_ACC  = 4,
          ST_UPDATE     = 5,
          ST_CHECK      = 6,// should move before out
          ST_OUTPUT     = 7;

reg     [3:0] current_state,
              next_state;

reg     [19:0] accu_element_x0,
               accu_element_y0,
               accu_element_x1,
               accu_element_y1,
               accu_element_x2,
               accu_element_y2,
               accu_element_x3,
               accu_element_y3;


reg     [11:0] data_num0,
               data_num1,
               data_num2,
               data_num3;

reg     [15:0]  mem_out;

/*
 *  Initial Point input (4)
 *
 */

reg             in_valid_div_relay;
always @(posedge clk) begin
  if (!rst_n) 
    in_valid_div_relay <= 1'b0;        
  else if (current_state == ST_UPDATE) 
    in_valid_div_relay <= 1'b1;
  else 
    in_valid_div_relay <= 1'b0;
end


reg             in_valid_div;

always @(posedge clk) begin
  if (!rst_n) 
    in_valid_div <= 1'b0;        
  else if (current_state==ST_UPDATE && !in_valid_div_relay) 
    in_valid_div <= 1'b1;
  else 
    in_valid_div <= 1'b0;
end
/***********************************************/

wire      [7:0] out_data_wire_x0;
wire            out_valid_div_x0;
reg       [7:0] out_data_x0;
always @(posedge clk) begin
  if (!rst_n) 
    out_data_x0 <= 'd0;        
  else if (current_state== ST_UPDATE && out_valid_div_x0) 
    out_data_x0 <= out_data_wire_x0;
  else if (current_state == ST_CHECK)
    out_data_x0 <= 'd0;
end

reg             out_flag_x0;
always @(posedge clk) begin
  if (!rst_n) 
    out_flag_x0 <= 1'b0;        
  else if (current_state== ST_UPDATE && out_valid_div_x0) 
    out_flag_x0 <= 1'b1;
  else if (current_state == ST_CHECK)
    out_flag_x0 <= 1'b0;
end
        
Division div_x0(
    .clk        (clk),
    .rst_n      (rst_n),
    .in_valid   (in_valid_div),
    .in_data_1  (accu_element_x0),
    .in_data_2  (data_num0),
    .out_valid  (out_valid_div_x0),
    .out_data   (out_data_wire_x0)
);

wire      [7:0] out_data_wire_y0;
wire            out_valid_div_y0;
reg       [7:0] out_data_y0;
always @(posedge clk) begin
  if (!rst_n) 
    out_data_y0 <= 'd0;        
  else if (current_state== ST_UPDATE && out_valid_div_y0) 
    out_data_y0 <= out_data_wire_y0;
  else if (current_state == ST_CHECK)
    out_data_y0 <= 'd0;
end

reg             out_flag_y0;
always @(posedge clk) begin
  if (!rst_n) 
    out_flag_y0 <= 1'b0;        
  else if (current_state== ST_UPDATE && out_valid_div_y0) 
    out_flag_y0 <= 1'b1;
  else if (current_state == ST_CHECK)
    out_flag_y0 <= 1'b0;
end
        
Division div_y0(
    .clk        (clk),
    .rst_n      (rst_n),
    .in_valid   (in_valid_div),
    .in_data_1  (accu_element_y0),
    .in_data_2  (data_num0),
    .out_valid  (out_valid_div_y0),
    .out_data   (out_data_wire_y0)
);

/////////////////////////////////////////////////////////////////


wire      [7:0] out_data_wire_x1;
wire            out_valid_div_x1;
reg       [7:0] out_data_x1;
always @(posedge clk) begin
  if (!rst_n) 
    out_data_x1 <= 'd0;        
  else if (current_state== ST_UPDATE && out_valid_div_x1) 
    out_data_x1 <= out_data_wire_x1;
  else if (current_state == ST_CHECK)
    out_data_x1 <= 'd0;
end

reg             out_flag_x1;
always @(posedge clk) begin
  if (!rst_n) 
    out_flag_x1 <= 1'b0;        
  else if (current_state== ST_UPDATE && out_valid_div_x1) 
    out_flag_x1 <= 1'b1;
  else if (current_state == ST_CHECK)
    out_flag_x1 <= 1'b0;
end
        
Division div_x1(
    .clk        (clk),
    .rst_n      (rst_n),
    .in_valid   (in_valid_div),
    .in_data_1  (accu_element_x1),
    .in_data_2  (data_num1),
    .out_valid  (out_valid_div_x1),
    .out_data   (out_data_wire_x1)
);

wire      [7:0] out_data_wire_y1;
wire            out_valid_div_y1;
reg       [7:0] out_data_y1;
always @(posedge clk) begin
  if (!rst_n) 
    out_data_y1 <= 'd0;        
  else if (current_state== ST_UPDATE && out_valid_div_y1) 
    out_data_y1 <= out_data_wire_y1;
  else if (current_state == ST_CHECK)
    out_data_y1 <= 'd0;
end

reg             out_flag_y1;
always @(posedge clk) begin
  if (!rst_n) 
    out_flag_y1 <= 1'b0;        
  else if (current_state== ST_UPDATE && out_valid_div_y1) 
    out_flag_y1 <= 1'b1;
  else if (current_state == ST_CHECK)
    out_flag_y1 <= 1'b0;
end
        
Division div_y1(
    .clk        (clk),
    .rst_n      (rst_n),
    .in_valid   (in_valid_div),
    .in_data_1  (accu_element_y1),
    .in_data_2  (data_num1),
    .out_valid  (out_valid_div_y1),
    .out_data   (out_data_wire_y1)
);

/////////////////////////////////////////////////////////////////

wire      [7:0] out_data_wire_x2;
wire            out_valid_div_x2;
reg       [7:0] out_data_x2;
always @(posedge clk) begin
  if (!rst_n) 
    out_data_x2 <= 'd0;        
  else if (current_state== ST_UPDATE && out_valid_div_x2) 
    out_data_x2 <= out_data_wire_x2;
  else if (current_state == ST_CHECK)
    out_data_x2 <= 'd0;
end

reg             out_flag_x2;
always @(posedge clk) begin
  if (!rst_n) 
    out_flag_x2 <= 1'b0;        
  else if (current_state== ST_UPDATE && out_valid_div_x2) 
    out_flag_x2 <= 1'b1;
  else if (current_state == ST_CHECK)
    out_flag_x2 <= 1'b0;
end
        
Division div_x2(
    .clk        (clk),
    .rst_n      (rst_n),
    .in_valid   (in_valid_div),
    .in_data_1  (accu_element_x2),
    .in_data_2  (data_num2),
    .out_valid  (out_valid_div_x2),
    .out_data   (out_data_wire_x2)
);

wire      [7:0] out_data_wire_y2;
wire            out_valid_div_y2;
reg       [7:0] out_data_y2;
always @(posedge clk) begin
  if (!rst_n) 
    out_data_y2 <= 'd0;        
  else if (current_state== ST_UPDATE && out_valid_div_y2) 
    out_data_y2 <= out_data_wire_y2;
  else if (current_state == ST_CHECK)
    out_data_y2 <= 'd0;
end

reg             out_flag_y2;
always @(posedge clk) begin
  if (!rst_n) 
    out_flag_y2 <= 1'b0;        
  else if (current_state== ST_UPDATE && out_valid_div_y2) 
    out_flag_y2 <= 1'b1;
  else if (current_state == ST_CHECK)
    out_flag_y2 <= 1'b0;
end
        
Division div_y2(
    .clk        (clk),
    .rst_n      (rst_n),
    .in_valid   (in_valid_div),
    .in_data_1  (accu_element_y2),
    .in_data_2  (data_num2),
    .out_valid  (out_valid_div_y2),
    .out_data   (out_data_wire_y2)
);

/////////////////////////////////////////////////////////////////

wire      [7:0] out_data_wire_x3;
wire            out_valid_div_x3;
reg       [7:0] out_data_x3;
always @(posedge clk) begin
  if (!rst_n) 
    out_data_x3 <= 'd0;        
  else if (current_state== ST_UPDATE && out_valid_div_x3) 
    out_data_x3 <= out_data_wire_x3;
  else if (current_state == ST_CHECK)
    out_data_x3 <= 'd0;
end

reg             out_flag_x3;
always @(posedge clk) begin
  if (!rst_n) 
    out_flag_x3 <= 1'b0;        
  else if (current_state== ST_UPDATE && out_valid_div_x3) 
    out_flag_x3 <= 1'b1;
  else if (current_state == ST_CHECK)
    out_flag_x3 <= 1'b0;
end
        
Division div_x3(
    .clk        (clk),
    .rst_n      (rst_n),
    .in_valid   (in_valid_div),
    .in_data_1  (accu_element_x3),
    .in_data_2  (data_num3),
    .out_valid  (out_valid_div_x3),
    .out_data   (out_data_wire_x3)
);

wire      [7:0] out_data_wire_y3;
wire            out_valid_div_y3;
reg       [7:0] out_data_y3;
always @(posedge clk) begin
  if (!rst_n) 
    out_data_y3 <= 'd0;        
  else if (current_state== ST_UPDATE && out_valid_div_y3) 
    out_data_y3 <= out_data_wire_y3;
  else if (current_state == ST_CHECK)
    out_data_y3 <= 'd0;
end

reg             out_flag_y3;
always @(posedge clk) begin
  if (!rst_n) 
    out_flag_y3 <= 1'b0;        
  else if (current_state== ST_UPDATE && out_valid_div_y3) 
    out_flag_y3 <= 1'b1;
  else if (current_state == ST_CHECK)
    out_flag_y3 <= 1'b0;
end
        
Division div_y3(
    .clk        (clk),
    .rst_n      (rst_n),
    .in_valid   (in_valid_div),
    .in_data_1  (accu_element_y3),
    .in_data_2  (data_num3),
    .out_valid  (out_valid_div_y3),
    .out_data   (out_data_wire_y3)
);

/////////////////////////////////////////////////////////////////
reg      [1:0]  init_in_count;
always @(posedge clk) begin
  if (!rst_n) 
    init_in_count <= 'd0;    
  else if (current_state==ST_INIT_INPUT || (current_state==ST_IDLE && in_valid)) 
    init_in_count <= init_in_count + 'd1;
  else
    init_in_count <= 'd0;
end


reg     [15:0]  current_element0;
always @(posedge clk) begin
  if (!rst_n)
    current_element0 <= 'd0;    
  else if (( current_state==ST_INIT_INPUT || (current_state==ST_IDLE && in_valid) ) && init_in_count=='d0)
    current_element0 <= in_data;
  else if (current_state==ST_UPDATE && data_num0!='d0 && out_flag_x0 && out_flag_y0) begin
    current_element0[15:8] <= out_data_x0;
    current_element0[7:0]  <= out_data_y0;
  end
  else if (current_state == ST_IDLE)
    current_element0 <= 'd0;
end

reg     [15:0]  current_element1;
always @(posedge clk) begin
  if (!rst_n)
    current_element1 <= 'd0;    
  else if (( current_state==ST_INIT_INPUT || (current_state==ST_IDLE && in_valid) ) && init_in_count=='d1)
    current_element1 <= in_data;
  else if (current_state==ST_UPDATE && data_num1!='d0 && out_flag_x1 && out_flag_y1) begin
    current_element1[15:8] <= out_data_x1;
    current_element1[7:0]  <= out_data_y1;
  end
  else if (current_state == ST_IDLE)
    current_element1 <= 'd0;
end

reg     [15:0]  current_element2;
always @(posedge clk) begin
  if (!rst_n)
    current_element2 <= 'd0;    
  else if (( current_state==ST_INIT_INPUT || (current_state==ST_IDLE && in_valid) ) && init_in_count=='d2)
    current_element2 <= in_data;
  else if (current_state==ST_UPDATE && data_num2!='d0 && out_flag_x2 && out_flag_y2) begin
    current_element2[15:8] <= out_data_x2;
    current_element2[7:0]  <= out_data_y2;
  end
  else if (current_state == ST_IDLE)
    current_element2 <= 'd0;
end

reg     [15:0]  current_element3;
always @(posedge clk) begin
  if (!rst_n)
    current_element3 <= 'd0;    
  else if (( current_state==ST_INIT_INPUT || (current_state==ST_IDLE && in_valid) ) && init_in_count=='d3)
    current_element3 <= in_data;
  else if (current_state==ST_UPDATE && data_num3!='d0 && out_flag_x3 && out_flag_y3) begin
    current_element3[15:8] <= out_data_x3;
    current_element3[7:0]  <= out_data_y3;
  end
  else if (current_state == ST_IDLE)
    current_element3 <= 'd0;
end

/*
 *  Data input (4096)
 *
 */
reg     [11:0]   mem_count_in;
always @(posedge clk) begin
  if (!rst_n)
    mem_count_in <= 'd0;    
  else if ( current_state==ST_DATA_INPUT )
    mem_count_in <= mem_count_in + 'd1;
  else
    mem_count_in <= 'd0;
end



reg     [15:0]  mem_din;
always @(posedge clk) begin
  if (!rst_n)
    mem_din <= #1'd0;        
  else if ( current_state==ST_DATA_INPUT )
    mem_din <= #1 in_data;
  else
    mem_din <= #1 'd0;
end

reg             mem_we_b;
always @(posedge clk) begin
  if (!rst_n)
    mem_we_b <= #1 1'b1;        
  else if ( current_state==ST_DATA_INPUT && in_valid )
    mem_we_b <= #1 1'b0;
  else if(!in_valid)
    mem_we_b <= #1 1'b1;
end

/*
 *  CHECK && SYNC
 *
 */
reg     dummy_check_count;//add another state to eliminate this dummy
always @(posedge clk) begin
  if (!rst_n) 
    dummy_check_count <= 'd0;    
  else if (current_state == ST_CHECK)
    dummy_check_count <= 'd1;
  else 
    dummy_check_count <= 'd0;
end

reg     sync_done;
always @(posedge clk) begin
  if (!rst_n) 
    sync_done <= 1'b0;
  else if (current_state==ST_CHECK && dummy_check_count=='d1)
    sync_done <= 1'b1;
  else
    sync_done <= 1'b0;
end


reg     dummy_sync_count;//add another state to eliminate this dummy
always @(posedge clk) begin
  if (!rst_n) 
    dummy_sync_count <= 'd0;    
  else if (current_state == ST_SYNC)
    dummy_sync_count <= 'd1;
  else 
    dummy_sync_count <= 'd0;
end

reg     input_sync;
always @(posedge clk) begin
  if (!rst_n) 
    input_sync <= 1'b0;
  else if (current_state==ST_SYNC && dummy_sync_count=='d1)
    input_sync <= 1'b1;
  else
    input_sync <= 1'b0;
end


/*
 *  GROUP AND ACCUMULATE
 *
 */
 //INNER LOOP
reg     [2:0] group_acc_clus_count;
always @(posedge clk) begin
  if (!rst_n)
    group_acc_clus_count <= 'd0;    
  else if (current_state==ST_GROUP_ACC && group_acc_clus_count<'d4) 
    group_acc_clus_count <= group_acc_clus_count + 'd1;    
  else
    group_acc_clus_count <= 'd0;
end

//OUTER LOOP
reg     [12:0] group_acc_element_count;
always @(posedge clk) begin
  if (!rst_n)
    group_acc_element_count <= 'd0;    
  else if (current_state==ST_GROUP_ACC && group_acc_clus_count=='d4) 
    group_acc_element_count <= group_acc_element_count + 'd1;    
  else if (current_state == ST_CHECK)
    group_acc_element_count <= 'd0;
end

////COUNTER for MEM
//reg     [11:0]  total_element_count;
//always @(posedge clk) begin
//  if (!rst_n)
//    total_element_count <= 'd0;    
//  end
//  else if (current_state==ST_CHECK || current_state==ST_GROUP_ACC)//start counting 2 cycle(s) earlier
//    total_element_count <= total_element_count + 'd1;
//  else
//    total_element_count <= 'd0;
//end

reg     [15:0] total_element_relay;//from mem
always @(posedge clk) begin
  if (!rst_n)
    total_element_relay <= 'd0;        
  else if (current_state==ST_GROUP_ACC || (current_state==ST_CHECK && sync_done) || (current_state==ST_SYNC && input_sync))//start 1 cycle(s) earlier
    total_element_relay <= mem_out;    
end

//wire    [15:0]  total_element_hold_time_fix = (!rst_n)? 'd0:total_element_relay;

reg     [15:0] total_element;//from mem
always @(posedge clk) begin
  if (!rst_n)
    total_element <= 'd0;        
  else if (current_state==ST_GROUP_ACC || (current_state==ST_CHECK && sync_done) || (current_state==ST_SYNC && input_sync))//start 1 cycle(s) earlier
    total_element <= total_element_relay;    
end



wire [7:0] delta_x0 = (total_element[15:8]>current_element0[15:8])?
 (total_element[15:8]-current_element0[15:8]):(current_element0[15:8]-total_element[15:8]);
wire [7:0] delta_x1 = (total_element[15:8]>current_element1[15:8])?
 (total_element[15:8]-current_element1[15:8]):(current_element1[15:8]-total_element[15:8]);
wire [7:0] delta_x2 = (total_element[15:8]>current_element2[15:8])?
 (total_element[15:8]-current_element2[15:8]):(current_element2[15:8]-total_element[15:8]);
wire [7:0] delta_x3 = (total_element[15:8]>current_element3[15:8])?
 (total_element[15:8]-current_element3[15:8]):(current_element3[15:8]-total_element[15:8]);

wire [7:0] delta_y0 = (total_element[7:0]>current_element0[7:0])?
 (total_element[7:0]-current_element0[7:0]):(current_element0[7:0]-total_element[7:0]);
wire [7:0] delta_y1 = (total_element[7:0]>current_element1[7:0])?
 (total_element[7:0]-current_element1[7:0]):(current_element1[7:0]-total_element[7:0]);
wire [7:0] delta_y2 = (total_element[7:0]>current_element2[7:0])?
 (total_element[7:0]-current_element2[7:0]):(current_element2[7:0]-total_element[7:0]);
wire [7:0] delta_y3 = (total_element[7:0]>current_element3[7:0])?
 (total_element[7:0]-current_element3[7:0]):(current_element3[7:0]-total_element[7:0]);

reg     [8:0] distance;
always @(*) begin
  case (group_acc_clus_count) 
    'd0: begin
      distance = delta_x0 + delta_y0;
    end
    'd1: begin
      distance = delta_x1 + delta_y1;
    end
    'd2: begin
      distance = delta_x2 + delta_y2;
    end
    'd3: begin
      distance = delta_x3 + delta_y3;
    end
    default: distance = 0;
  endcase
end

//wire  [8:0] min_distance = (group_acc_clus_count==0 || distance<min_distance)? distance:min_distance;
//wire  [1:0] min_idx = (group_acc_clus_count==0 || distance<min_distance)? group_acc_clus_count:min_idx;
reg     [8:0] min_distance;
always @(posedge clk) begin
  if (!rst_n) 
    min_distance <= 'd0;    
  else if (current_state==ST_GROUP_ACC && (group_acc_clus_count==0 || distance<min_distance) && group_acc_clus_count!='d4)
    min_distance <= distance;
end

reg     [1:0] min_idx;
always @(posedge clk) begin
  if (!rst_n) 
    min_idx <= 'd0;    
  else if (current_state==ST_GROUP_ACC && (group_acc_clus_count==0 || distance<min_distance) && group_acc_clus_count!='d4)
    min_idx <= group_acc_clus_count;
end

//DATA_NUM (CAN SHARE SAME ADDER)

reg      [11:0]  data_num_wire0;
reg      [11:0]  data_num_wire1;
reg      [11:0]  data_num_wire2;
reg      [11:0]  data_num_wire3;
always @(*) begin
  case (min_idx) 
    'd0: begin
      data_num_wire0 = data_num0 + 'd1;
      data_num_wire1 = data_num1;
      data_num_wire2 = data_num2;
      data_num_wire3 = data_num3;
    end
    'd1: begin
      data_num_wire0 = data_num0;
      data_num_wire1 = data_num1 + 'd1;
      data_num_wire2 = data_num2;
      data_num_wire3 = data_num3;
    end
    'd2: begin
      data_num_wire0 = data_num0;
      data_num_wire1 = data_num1;
      data_num_wire2 = data_num2 + 'd1;
      data_num_wire3 = data_num3;
    end
    'd3: begin
      data_num_wire0 = data_num0;
      data_num_wire1 = data_num1;
      data_num_wire2 = data_num2;
      data_num_wire3 = data_num3 + 'd1;
    end
    default: begin
      data_num_wire0 = data_num0;
      data_num_wire1 = data_num1;
      data_num_wire2 = data_num2;
      data_num_wire3 = data_num3;
    end
  endcase
end

always @(posedge clk) begin
  if (!rst_n)
    data_num0 <= 'd0;    
  else if (current_state==ST_GROUP_ACC && group_acc_clus_count=='d4 && min_idx=='d0) 
    data_num0 <= data_num_wire0;    
  else if (current_state == ST_CHECK)
    data_num0 <= 'd0;
end
always @(posedge clk) begin
  if (!rst_n)
    data_num1 <= 'd0;    
  else if (current_state==ST_GROUP_ACC && group_acc_clus_count=='d4 && min_idx=='d1) 
    data_num1 <= data_num_wire1;    
  else if (current_state == ST_CHECK)
    data_num1 <= 'd0;
end
always @(posedge clk) begin
  if (!rst_n)
    data_num2 <= 'd0;    
  else if (current_state==ST_GROUP_ACC && group_acc_clus_count=='d4 && min_idx=='d2) 
    data_num2 <= data_num_wire2;    
  else if (current_state == ST_CHECK)
    data_num2 <= 'd0;
end
always @(posedge clk) begin
  if (!rst_n)
    data_num3 <= 'd0;    
  else if (current_state==ST_GROUP_ACC && group_acc_clus_count=='d4 && min_idx=='d3) 
    data_num3 <= data_num_wire3;    
  else if (current_state == ST_CHECK)
    data_num3 <= 'd0;
end


//ACCU ELEMENT

reg      [19:0]  accu_element_wirex0;
reg      [19:0]  accu_element_wirex1;
reg      [19:0]  accu_element_wirex2;
reg      [19:0]  accu_element_wirex3;
reg      [19:0]  accu_element_wirey0;
reg      [19:0]  accu_element_wirey1;
reg      [19:0]  accu_element_wirey2;
reg      [19:0]  accu_element_wirey3;
always @(*) begin
  case(min_idx)
    'd0: begin
      accu_element_wirex0 = accu_element_x0 + total_element[15:8];
      accu_element_wirex1 = accu_element_x1;
      accu_element_wirex2 = accu_element_x2;
      accu_element_wirex3 = accu_element_x3;
      accu_element_wirey0 = accu_element_y0 + total_element[7:0];
      accu_element_wirey1 = accu_element_y1;
      accu_element_wirey2 = accu_element_y2;
      accu_element_wirey3 = accu_element_y3;
    end
    'd1: begin
      accu_element_wirex0 = accu_element_x0;
      accu_element_wirex1 = accu_element_x1 + total_element[15:8];
      accu_element_wirex2 = accu_element_x2;
      accu_element_wirex3 = accu_element_x3;
      accu_element_wirey0 = accu_element_y0;
      accu_element_wirey1 = accu_element_y1 + total_element[7:0];
      accu_element_wirey2 = accu_element_y2;
      accu_element_wirey3 = accu_element_y3;
    end
    'd2: begin
      accu_element_wirex0 = accu_element_x0;
      accu_element_wirex1 = accu_element_x1;
      accu_element_wirex2 = accu_element_x2 + total_element[15:8];
      accu_element_wirex3 = accu_element_x3;
      accu_element_wirey0 = accu_element_y0;
      accu_element_wirey1 = accu_element_y1;
      accu_element_wirey2 = accu_element_y2 + total_element[7:0];
      accu_element_wirey3 = accu_element_y3;
    end
    'd3: begin
      accu_element_wirex0 = accu_element_x0;
      accu_element_wirex1 = accu_element_x1;
      accu_element_wirex2 = accu_element_x2;
      accu_element_wirex3 = accu_element_x3 + total_element[15:8];
      accu_element_wirey0 = accu_element_y0;
      accu_element_wirey1 = accu_element_y1;
      accu_element_wirey2 = accu_element_y2;
      accu_element_wirey3 = accu_element_y3 + total_element[7:0];
    end
    default: begin
      accu_element_wirex0 = accu_element_x0;
      accu_element_wirex1 = accu_element_x1;
      accu_element_wirex2 = accu_element_x2;
      accu_element_wirex3 = accu_element_x3;
      accu_element_wirey0 = accu_element_y0;
      accu_element_wirey1 = accu_element_y1;
      accu_element_wirey2 = accu_element_y2;
      accu_element_wirey3 = accu_element_y3;
    end
  endcase
end


always @(posedge clk) begin
  if (!rst_n)
    accu_element_x0 <= 'd0;    
  else if (current_state==ST_GROUP_ACC && group_acc_clus_count=='d4 && min_idx=='d0) 
    accu_element_x0 <= accu_element_wirex0;    
  else if (current_state == ST_CHECK)
    accu_element_x0 <= 'd0;
end
always @(posedge clk) begin
  if (!rst_n)
    accu_element_y0 <= 'd0;    
  else if (current_state==ST_GROUP_ACC && group_acc_clus_count=='d4 && min_idx=='d0) 
    accu_element_y0 <= accu_element_wirey0;    
  else if (current_state == ST_CHECK)
    accu_element_y0 <= 'd0;
end


always @(posedge clk) begin
  if (!rst_n)
    accu_element_x1 <= 'd0;    
  else if (current_state==ST_GROUP_ACC && group_acc_clus_count=='d4 && min_idx=='d1) 
    accu_element_x1 <= accu_element_wirex1;    
  else if (current_state == ST_CHECK)
    accu_element_x1 <= 'd0;
end
always @(posedge clk) begin
  if (!rst_n)
    accu_element_y1 <= 'd0;    
  else if (current_state==ST_GROUP_ACC && group_acc_clus_count=='d4 && min_idx=='d1) 
    accu_element_y1 <= accu_element_wirey1;    
  else if (current_state == ST_CHECK)
    accu_element_y1 <= 'd0;
end

always @(posedge clk) begin
  if (!rst_n)
    accu_element_x2 <= 'd0;    
  else if (current_state==ST_GROUP_ACC && group_acc_clus_count=='d4 && min_idx=='d2) 
    accu_element_x2 <= accu_element_wirex2;    
  else if (current_state == ST_CHECK)
    accu_element_x2 <= 'd0;
end
always @(posedge clk) begin
  if (!rst_n)
    accu_element_y2 <= 'd0;    
  else if (current_state==ST_GROUP_ACC && group_acc_clus_count=='d4 && min_idx=='d2) 
    accu_element_y2 <= accu_element_wirey2;    
  else if (current_state == ST_CHECK)
    accu_element_y2 <= 'd0;
end

always @(posedge clk) begin
  if (!rst_n)
    accu_element_x3 <= 'd0;    
  else if (current_state==ST_GROUP_ACC && group_acc_clus_count=='d4 && min_idx=='d3) 
    accu_element_x3 <= accu_element_wirex3;    
  else if (current_state == ST_CHECK)
    accu_element_x3 <= 'd0;
end
always @(posedge clk) begin
  if (!rst_n)
    accu_element_y3 <= 'd0;    
  else if (current_state==ST_GROUP_ACC && group_acc_clus_count=='d4 && min_idx=='d3) 
    accu_element_y3 <= accu_element_wirey3;    
  else if (current_state == ST_CHECK)
    accu_element_y3 <= 'd0;
end


/*
 *  UPDATE CLUSTER POSITION (Done in Parallel)
 *
 */

//reg             update_done;
//always @(posedge clk) begin
//  if (!rst_n) 
//    update_done <= 1'b0;    
//  else if (current_state == ST_UPDATE) 
//    update_done <= 1'b1;
//  else 
//    update_done <= 1'b0;
//end



//DONT NEED PREVIOUS, JUST COMPARE DIVIDE RESULT WITH CURRENT 

reg       [15:0]  previous_element0;
always @(posedge clk) begin
  if (!rst_n)
    previous_element0 <= 'd0;    
  else if (current_state==ST_UPDATE && in_valid_div)  
    previous_element0 <= current_element0;
  else if (current_state == ST_IDLE)
    previous_element0 <= 'd0;
end

reg       [15:0]  previous_element1;
always @(posedge clk) begin
  if (!rst_n)
    previous_element1 <= 'd0;    
  else if (current_state==ST_UPDATE && in_valid_div)  
    previous_element1 <= current_element1;
  else if (current_state == ST_IDLE)
    previous_element1 <= 'd0;
end

reg       [15:0]  previous_element2;
always @(posedge clk) begin
  if (!rst_n)
    previous_element2 <= 'd0;    
  else if (current_state==ST_UPDATE && in_valid_div)  
    previous_element2 <= current_element2;
  else if (current_state == ST_IDLE)
    previous_element2 <= 'd0;
end

reg       [15:0]  previous_element3;
always @(posedge clk) begin
  if (!rst_n)
    previous_element3 <= 'd0;    
  else if (current_state==ST_UPDATE && in_valid_div) 
    previous_element3 <= current_element3;
  else if (current_state == ST_IDLE)
    previous_element3 <= 'd0;
end

wire  update_done = out_flag_x0 & out_flag_x1 & out_flag_x2 & out_flag_x3 & out_flag_y0 & out_flag_y1 & out_flag_y2 & out_flag_y3;



/*
 *  OUTPUT
 *
 */

always @(posedge clk) begin
  if (!rst_n)
    out_valid <= 1'b0;  
  else if(current_state==ST_OUTPUT)
    out_valid <= 1'b1;
  else
    out_valid <= 1'b0;
end


reg     [1:0]   output_count;
always @(posedge clk) begin
  if (!rst_n)
    output_count <= 'd0;    
  else if (current_state == ST_OUTPUT)
    output_count <= output_count + 'd1;
  else
    output_count <= 'd0;
end

always @(posedge clk) begin
  if (!rst_n) begin
    out_data <= 'd0;    
  end
  else if (current_state == ST_OUTPUT) begin
    case(output_count)
    'd0: begin
      out_data <= current_element0;
    end
    'd1: begin
      out_data <= current_element1;
    end
    'd2: begin
      out_data <= current_element2;
    end
    'd3: begin
      out_data <= current_element3;
    end
    default: out_data <= 'd0;
    endcase
  end
end

/*
 *  MEM CONTROL
 *
 */
 reg        [11:0]  mem_addr;
always @(posedge clk) begin
  if (!rst_n) 
    mem_addr <= 'd0;
  else if ( current_state==ST_DATA_INPUT || (current_state==ST_INIT_INPUT && in_valid) ) 
    mem_addr <= mem_count_in;
  else if (current_state==ST_CHECK || current_state==ST_SYNC)
    mem_addr <= 'd0;
  else if (current_state==ST_GROUP_ACC && group_acc_element_count!=DATA_SIZE)
    mem_addr <= group_acc_element_count + 1;
end

wire      [15:0]  mem_out_net;
always @(posedge clk) begin
  if (!rst_n) 
    mem_out <= 'd0;    
  else  
    mem_out <= mem_out_net;
end


/*
 *  FSM
 *
 */

always @(posedge clk) begin
  if (!rst_n) begin
    current_state <= ST_IDLE;    
  end
  else begin
    current_state <= next_state;
  end
end



/*
 *  Check
 *
 */

wire  init_input_done = (init_in_count==3)? 1'b1:1'b0;

wire  element0_status = (previous_element0==current_element0)? 1'b1:1'b0;
wire  element1_status = (previous_element1==current_element1)? 1'b1:1'b0;
wire  element2_status = (previous_element2==current_element2)? 1'b1:1'b0;
wire  element3_status = (previous_element3==current_element3)? 1'b1:1'b0;
wire  check_success   = element0_status & element1_status & element2_status & element3_status;//SUCCESS!!

wire  output_done     = (output_count=='d3)? 1'b1:1'b0;
always @(*) begin
  case(current_state)
    ST_IDLE: begin
      if(in_valid)
        next_state = ST_INIT_INPUT;
      else
        next_state = ST_IDLE;
    end
    ST_INIT_INPUT: begin
      if(init_input_done)
        next_state = ST_DATA_INPUT;
      else
        next_state = ST_INIT_INPUT;
    end
    ST_DATA_INPUT: begin
      if(!in_valid)
        next_state = ST_SYNC;
      else
        next_state = ST_DATA_INPUT;
    end
    ST_SYNC: begin
      if(input_sync)
        next_state = ST_GROUP_ACC;
      else 
        next_state = ST_SYNC;
    end
    ST_GROUP_ACC: begin
      if ( group_acc_element_count == DATA_SIZE )
        next_state = ST_UPDATE;
      else 
        next_state = ST_GROUP_ACC;
    end
    ST_UPDATE: begin
      if(update_done)
        next_state = ST_CHECK;
      else
        next_state = ST_UPDATE;
    end
    ST_CHECK: begin
      if(!check_success && sync_done)//takes 2 cycles to transition from ST_CHECK to ST_GROUP_ACC
        next_state = ST_GROUP_ACC;
      else if(check_success)
        next_state = ST_OUTPUT;
      else
        next_state = ST_CHECK;
    end
    ST_OUTPUT: begin
      if(output_done)
        next_state = ST_IDLE;
      else 
        next_state = ST_OUTPUT;
    end

    default:
      next_state = ST_IDLE;
        
  endcase
end

SHAB90_4096X16X1CM16 u_SHAB90_4096X16X1CM16(
  .A    (mem_addr),
  .DI   (mem_din),
  .DO   (mem_out_net),
  .WEB  (mem_we_b),
  .CK   (clk),
  .OE   (1'd1),
  .CS   (1'd1)
);

endmodule