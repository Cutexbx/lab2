`timescale 1ns / 1ps

module cordic(
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

reg[15:0] atans[9:0];

output reg[15:0] x,y,z;

wire d;

assign d=mode?(~y[15]):z[15];

reg[7:0] k;

always@(posedge clk or negedge rst)begin
    if(~rst)begin
        atans[0]<=6434;
        atans[1]<=3798;
        atans[2]<=2007;
        atans[3]<=1019;
        atans[4]<=511;
        atans[5]<=256;
        atans[6]<=128;
        atans[7]<=64;
        atans[8]<=32;
        atans[9]<=16;
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
                x<=x+(y>>k);
                y<=y-(x>>k);
                z<=z+atans[k];
            end
            else begin//pos
                x<=x-(y>>k);
                y<=y+(x>>k);
                z<=z-atans[k];
            end
            k<=k+1;
        end
    end
end


endmodule
