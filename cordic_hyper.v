`timescale 1ns / 1ps

module cordic_hyper(
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

input clk,rst;
input mode,load;
input[15:0] x0,y0,z0;

reg[15:0] atanhs[9:0];

output reg[15:0] x,y,z;

wire d;

assign d=mode?(~y[15]):z[15];

reg[7:0] k;

always@(posedge clk or negedge rst)begin
    if(~rst)begin
        atanhs[0]<=4500;
        atanhs[1]<=2092;
        atanhs[2]<=1029;
        atanhs[3]<=513;
        atanhs[4]<=256;
        atanhs[5]<=128;
        atanhs[6]<=64;
        atanhs[7]<=32;
        atanhs[8]<=16;
        atanhs[9]<=8;
        x<=0;
        y<=0;
        z<=0;
        k<=0;
    end
    else begin
        if(load)begin
            x<=x0;
            y<=y0;
            z<=z0;
            k<=0;
        end
        else begin
            if(d)begin//neg
                x<=x-(y>>(k+1));
                y<=y-(x>>(k+1));
                z<=z+atanhs[k];
            end
            else begin//pos
                x<=x+(y>>(k+1));
                y<=y+(x>>(k+1));
                z<=z-atanhs[k];
            end
            k<=k+1;
        end
    end
end


endmodule
