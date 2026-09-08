module xor_gate (
    output wire y,
    input  wire a,
    input  wire b
);

    xor xor1 (y, a, b);

endmodule
