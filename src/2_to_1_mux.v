// Y = \overline{S}D_0 + SD_1

module mux_2to1 (
    output wire mux_out,
    input  wire din_0,
    input  wire din_1,
    input  wire sel
);

wire w_not1, w_and1, w_and2;

not not1(w_not1, sel);
and and1(w_and1, w_not1, din_0);
and and2(w_and2, sel, din_1);
or or1(mux_out, w_and1, w_and2);

endmodule