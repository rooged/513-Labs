module add_sub_4b_tb();

reg[3:0] a,b;
reg ctrl;

wire [3:0] s, cout;

add_sub_4b ca(.a(a),.b(b),.cin(cin),.ctrl(ctrl),.s(s),.cout(cout));

initial begin
    #10 a=4'b0001; b=4'b0010; ctrl=1'b0; //sum should be 0011
    #10 a=4'b0010; b=4'b0001; ctrl=1'b1; //sum should be 0001
    #10 a=4'b0011; b=4'b0001; ctrl=1'b0; //sum should be 0100
    #10 a=4'b1000; b=4'b0011; ctrl=1'b1; //sum should be 0101
    #10 a=4'b1000; b=4'b0011; ctrl=1'b0; //sum should be 1011
    #10 a=4'b1010; b=4'b1010; ctrl=1'b1; //sum should be 0000
    #10 a=4'b1010; b=4'b1010; ctrl=1'b0; //sum should be (01)0100
    #10 a=4'b1001; b=4'b0011; ctrl=1'b1; //sum should be 0110
    #10 a=4'b1111; b=4'b0001; ctrl=1'b1; //sum should be 1110
    //#10 $finish;
end
endmodule