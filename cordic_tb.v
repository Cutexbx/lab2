`timescale 1ns / 1ps

module cordic_tb(
xo,yo,zo
    );

reg clk,rst;
reg[15:0] x0,y0,z0;
wire[15:0] x,y,z;
output reg[15:0] xo,yo,zo;
reg mode,load;

cordic c0(
clk,
rst,
mode,
load,
x0,
y0,
z0,
x,
y,
z
    );

reg [7:0] state;
reg [7:0] k;

initial begin
clk=0;
rst=0;
x0<=0;
y0<=0;
z0<=0;
mode<=0;
load<=0;
state<=0;
k<=0;
#4 rst=1;
end

always #1 begin
    clk<=~clk;
end

always@(posedge clk)begin
    if(rst)begin
        case(state)
        0:begin
            mode<=0;
            load<=1;
            x0<=8192;//1.0
            y0<=0;
            z0<=8579;//pi/3
            k<=0;
            state<=state+1;
        end
        1:begin
            load<=0;
            if(k==11)begin
                xo<=x;
                yo<=y;
                zo<=z;
                state<=state+1;
            end
            k<=k+1;
        end
        2:begin
            mode<=1;
            load<=1;
            x0<=8192;//1.0
            y0<=8192;//1.0;
            z0<=0;
            k<=0;
            state<=state+1;
        end
        3:begin
             load<=0;
             if(k==11)begin
                 xo<=x;
                 yo<=y;
                 zo<=z;
                 state<=state+1;
             end
             k<=k+1;
        end
        4:begin
        end
        endcase
    end
end

endmodule
