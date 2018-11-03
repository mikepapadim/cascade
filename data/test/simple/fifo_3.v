reg[3:0] COUNT = 0;
wire[3:0] rdata;
wire empty, full;

Fifo#(1,3) fifo(
  .clock(clock.val),
  .wreq(COUNT < 4),
  .wdata(COUNT+1),
  .rreq(COUNT >= 1),
  .rdata(rdata),
  .empty(empty),
  .full(full)
);

always @(posedge clock.val) begin
  COUNT <= COUNT + 1;
  if (COUNT == 6) begin
    $finish;
  end 
  // On COUNT 0 we're pushing, so by COUNT 1, we should see full fifo
  if (COUNT < 2) begin
    $write("%h%h", empty, full);
  end 
  // Beginning from COUNT 1, we're pushing and popping, so we should start to
  // see values, but the queue will stay full until we stop pushing.
  else begin
    $write("%h%h%h", rdata, empty, full);
  end
end
