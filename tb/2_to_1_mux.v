module stimulus;
reg sel;
reg din_0, din_1;
wire mux_out;

mux_2to1 mux1(mux_out, din_0, din_1, sel);

initial begin
    din_0   = 1'b0;
    din_1   = 1'b1;
    sel     = 1'b0;
end

always begin
    #5 sel      = ~sel;
    #5 din_0   = ~din_0;
    #5 din_1   = ~din_1;
end

initial begin
    #100 $finish;
end

initial begin
    $monitor ($time, ": d1=%d d2=%d sel=%d mux=%d", din_0, din_1, sel, mux_out);
end


endmodule