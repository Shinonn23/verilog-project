`timescale 1ns / 1ps

module tb_xor_gate;
    reg a;
    reg b;
    wire y;

    // Instantiate Design from src/
    xor_gate uut (
        .y(y),
        .a(a),
        .b(b)
    );

    initial begin
        $dumpfile("build/xor_gate.vcd");
        $dumpvars(0, tb_xor_gate);

        $display("Time\tA\tB\tY");
        $monitor("%0t\t%b\t%b\t%b", $time, a, b, y);

        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end
endmodule
