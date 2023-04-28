# 2D-Coordinate-Rotating-and-Vectoring-based-Design-Methodology-CORDIC-using-Verilog-HDL
# INDEX
## Table of Contents
* [2D coordinate rotating using verilog](#2D-coordinate-rotating-using-verilog) 
    + [Simulation output of rotating](#Simulation-output-of-rotating)
    + [Synthesis of rotating using GENUS](#Synthesis-of-rotating-using-GENUS)
   
* [2D coordinate vectoring using verilog](#2D-coordinate-vectoring-using-verilog) 
    + [Simulation output of vectoring](#Simulation-output-of-vectoring)
    + [Synthesis of vectoring using GENUS](#Synthesis-of-vectoring-using-GENUS)

* [Computing Transcendental Functions using Rotating and Vectoring based Design Methodology CORDIC](#Computing-Transcendental-Functions-using-Rotating-and-Vectoring-based-Design-Methodology-CORDIC) 
    + [SIMULATION OUTPUT of ROTATING_VECTORING](#SIMULATION-OUTPUT-of-ROTATING-VECTORING)
    + [Synthesis of rotating vectoring using GENUS](#Synthesis-of-rotating-vectoring-using-GENUS)
   
* [Doubly Pipeline in Rotating and Vectoring based Design Methodology CORDIC](#Doubly-Pipeline-in-Rotating-and-Vectoring-based-Design-Methodology-CORDIC) 
    + [SIMULATION OUTPUT of DOUBLY PIPELINE](#SIMULATION-OUTPUT-of-DOUBLY-PIPELINE)
    + [SYNTHESIS of DOUBLY PIPELINE using GENUS](#SYNTHESIS-of-DOUBLY-PIPELINE-using-GENUS)
   
# 2D coordinate rotating using verilog
## code
```verilog
module ROTATING(x0, y0, theta, xf, yf, clk);
  input clk;
  input [15:0] x0, y0;
  input [15:0] theta;
  output [15:0] xf, yf;
  wire [15:0] xi [0:7]; 
  wire [15:0] yi [0:7];
  reg [2:0] stage;
  wire [15:0] outangle [0:7];
  
  
  // instantiating
  
  //stage0
  cordics r0(clk, 3'd0, x0, y0, theta, 16'd45_00, 16'd0, xi[0], yi[0], outangle[0]);
  //stage1
  cordics r1(clk, 3'd1, xi[0], yi[0], theta, 16'd26_57, outangle[0], xi[1], yi[1], outangle[1]);
  //stage2
  cordics r2(clk, 3'd2, xi[1], yi[1], theta, 16'd14_04, outangle[1], xi[2], yi[2], outangle[2]); 
  //stage3
  cordics r3(clk, 3'd3, xi[2], yi[2], theta, 16'd7_13, outangle[2], xi[3], yi[3], outangle[3]);
  //stage4
  cordics r4(clk, 3'd4, xi[3], yi[3], theta, 16'd3_58, outangle[3], xi[4], yi[4], outangle[4]);  
  //stage5
  cordics r5(clk, 3'd5, xi[4], yi[4], theta, 16'd1_79, outangle[4], xi[5], yi[5], outangle[5]);
  //stage6
  cordics r6(clk, 3'd6, xi[5], yi[5], theta, 16'd89, outangle[5], xi[6], yi[6], outangle[6]);
  //stage7
  cordics r7(clk, 3'd7, xi[6], yi[6], theta, 16'd44, outangle[6], xi[7], yi[7], outangle[7]);
  assign xf = xi[7];
  assign yf = yi[7];
  // assign xf <= (xi[7]>>>1)+(xi[7]>>>4)+(xi[7]>>>5);
  //assign yf <= (yi[7]>>>1)+(yi[7]>>>4)+(yi[7]>>>5);
  
endmodule
  
  
module cordics(clk,stage,xi,yi,theta,uangle,inangle,xf,yf,outangle);
 input clk;
 input [2:0] stage;
 input [15:0] xi,yi,theta,inangle,uangle;
 output reg [15:0] xf,yf,outangle;

 always @(posedge clk)begin
   if((inangle)>theta)begin                                   //clockwise

    case({xi[15],yi[15]})
       2'b00 : begin
          xf <= xi+(yi>>stage);
            yf <= yi - (xi>>stage);
       end
       2'b01 : begin
          xf <= xi-((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) - (xi>>stage);
       end 
      2'b10 : begin
          xf <= -(16'hffff-xi+1)+(yi>>stage);
          yf <= yi +((16'hffff-xi+1)>>stage);
       end
      2'b11 : begin 
          xf <= -(16'hffff-xi+1)-((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) + ((16'hffff-xi+1)>>stage);
       end
    endcase
    outangle <= inangle-uangle;
   end
   
   else begin 
    case({xi[15],yi[15]})
       2'b00 : begin                                        //anticlockwise
          xf <= xi-(yi>>stage);
          yf <= yi + (xi>>stage);
        end
       2'b01 : begin
            xf <= xi + ((16'hffff-yi+1)>>stage);
            yf <= -(16'hffff-yi+1) + (xi>>stage);
        end 
       2'b10 : begin
          xf <= -((16'hffff-xi+1))-(yi>>stage);
          yf <= yi - ((16'hffff-xi+1)>>stage);
        end 
       2'b11 : begin
          xf <= -(16'hffff-xi+1)+((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) - ((16'hffff-xi+1)>>stage);
        end
    endcase
         outangle <= inangle+uangle;
   end
  end
endmodule
```
# TESTBENCH
```verilog
module ROTATING_TB #(parameter period=5);
  reg clk=0;
  reg [15:0]x0,y0;
  reg [15:0]theta;
  wire [15:0]xf,yf;
  always @(*)begin
    #period clk<=~clk;
    end
  ROTATING dut(x0,y0,theta,xf,yf,clk);
  initial begin
    {x0,y0,theta}={16'd3, 16'd4, 16'd5300};
   end
endmodule
```
# Simulation output of rotating
![image](https://user-images.githubusercontent.com/120499567/234966549-bb44ead5-fdb6-4dd4-99ff-386eda3070b4.png)


# Synthesis of rotating using GENUS

- First login to server
```verilog
ssh -X dic_lab_02@192.168.88.31
```
- Then create a working directory (ROTATING) at:
```
/DIG_DESIGN/INTERNS/dic_lab_02/ABHINAV/VECTORING/
```
- Then write the ROTATING.v and ROTATING.tcl file in the working directory.

- Now invoke CADENCE in the working directory

# Steps to invoke Cadence
```
tcsh
source /DIG_DESIGN02/APPLICATION_CMS/Cadence/cshrc_cadence
```
- Now invoke GENUS in the working directory
```
genus -legacy_ui
```
- Now to runs synthesis run the .tcl file using followig command
```
source ROTATING.tcl
```
### TERMINAL
![1](https://user-images.githubusercontent.com/120499567/234962155-62956c88-7f38-4af9-b914-473f08e65793.PNG)
![2](https://user-images.githubusercontent.com/120499567/234962331-342439ab-030b-4039-9499-a7d6a4dc4c78.PNG)
## SYNTHESIZED DESIGN

![3](https://user-images.githubusercontent.com/120499567/234962584-2fe2b4e6-d542-4faf-8367-429f92c24630.png)
![4](https://user-images.githubusercontent.com/120499567/234962893-b279216d-1a54-49fa-ae8d-30f2c88e5334.png)


# 2D coordinate vectoring using verilog

## code
```verilog
module VECTORING(clk,xi,yi,theta,R);
 input clk;
 input [15:0]xi,yi;
 output [15:0] R,theta;  
 reg[2:0]stage;
 wire [15:0]x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8;
 wire [15:0]outangle0,outangle1,outangle2,outangle3,outangle4,outangle5,outangle6,outangle7;
 //stage 0
   itteration i0(clk,3'd0,xi,yi,16'd0,16'd45_00,x1,y1,outangle0);
 //stage 1
   itteration i1(clk,3'd1,x1,y1,outangle0,16'd26_57,x2,y2,outangle1); 
 //stage 2
   itteration i2(clk,3'd2,x2,y2,outangle1,16'd14_04,x3,y3,outangle2);
 //stage 3
   itteration i3(clk,3'd3,x3,y3,outangle2,16'd7_13,x4,y4,outangle3);
 //stage 4
   itteration i4(clk,3'd4,x4,y4,outangle3,16'd3_58,x5,y5,outangle4); 
 //stage 5
   itteration i5(clk,3'd5,x5,y5,outangle4,16'd1_79,x6,y6,outangle5); 
 //stage 6
   itteration i6(clk,3'd6,x6,y6,outangle5,16'd89,x7,y7,outangle6);
 //stage 7
   itteration i7(clk,3'd7,x7,y7,outangle6,16'd44,x8,y8,outangle7); 
   
    assign R = x8;
    assign theta = outangle7;
  // assign xf = (x8>>>1)+(x8>>>4)+(x8>>>5);
   //assign yf = (y8>>>1)+(y8>>>4)+(y8>>>5);    
 endmodule
  
module itteration(clk,stage,xi,yi,initial_angle,micro_angle,xf,yf,out_angle);
 input clk;
 input [2:0] stage;
  input [15:0]xi,yi,initial_angle,micro_angle;
  output reg [15:0] xf,yf,out_angle;
  
//assign micro_angle[7:0] ={16'd448,16'd895,16'd1790,16'd3580,16'd7130,16'd14040,16'd26570,16'd45000};
 
 always @(posedge clk)begin
  /* 
   if(yi==16'd0)begin    
     xf <= xi;
     yf <= 0;
     out_angle <= initial_angle;
     end
  */
   if (yi[15])begin 
    case({xi[15],yi[15]})
       2'b00 : begin                              //anticlockwise
          xf <= xi-(yi>>stage);
          yf <= yi + (xi>>stage);
        end
       2'b01 : begin
            xf <= xi + ((16'hffff-yi+1)>>stage);
            yf <= -(16'hffff-yi+1) + (xi>>stage);
        end 
       2'b10 : begin
          xf <= -((16'hffff-xi+1))-(yi>>stage);
          yf <= yi - ((16'hffff-xi+1)>>stage);
        end 
       2'b11 : begin
          xf <= -(16'hffff-xi+1)+((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) - ((16'hffff-xi+1)>>stage);
        end
    endcase
         out_angle <= initial_angle-micro_angle;
   end

     else begin        //clockwise
    case({xi[15],yi[15]})
       2'b00 : begin
          xf <= xi+(yi>>stage);
            yf <= yi - (xi>>stage);
       end
       2'b01 : begin
          xf <= xi-((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) - (xi>>stage);
       end 
      2'b10 : begin
          xf <= -(16'hffff-xi+1)+(yi>>stage);
          yf <= yi +((16'hffff-xi+1)>>stage);
       end
      2'b11 : begin 
          xf <= -(16'hffff-xi+1)-((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) + ((16'hffff-xi+1)>>stage);
       end
    endcase
    out_angle <= micro_angle+initial_angle;
   end

   end
   endmodule
   ```
   
 ## TESTBENCH
 ```verilog
 module VECTORING_TB #(parameter period=5);
  reg clk=0;
  reg [15:0]xi,yi;
  wire [15:0]R,theta;
  always @(*)begin
    #period clk<=~clk;
    end
  VECTORING dut(clk,xi,yi,theta,R);
  initial begin
    {xi,yi}={16'd30, 16'd40};
   end
endmodule
```

## Simulation output of vectoring
![image](https://user-images.githubusercontent.com/120499567/234968621-223c9c2c-a31e-45c8-bda0-6ef17a41757a.png)

## Synthesis of vectoring using GENUS
![image](https://user-images.githubusercontent.com/120499567/234984148-97b84805-dc5f-4d65-8b1b-193a9a11431d.png)
![image](https://user-images.githubusercontent.com/120499567/234984431-4cdac3a4-d567-40ec-b090-67116a20de99.png)
## SYNTHESIZED DESIGN
![image](https://user-images.githubusercontent.com/120499567/234984820-85adfe87-a1b3-47d0-b990-1bbc95348eab.png)

![image](https://user-images.githubusercontent.com/120499567/234984970-7e9ecbfd-7055-4d02-9d44-1131536eeb39.png)


#Computing Transcendental Functions using Rotating and Vectoring based Design Methodology CORDIC
## code
```verilog
module ROTATING_VECTORING(clk,xi,yi,xf,yf);
 input clk;
 input [15:0]xi,yi; 
 output [15:0] xf,yf;
 wire [15:0]theta,norm;
 VECTORING first(clk,xi,yi,theta,norm);
 ROTATING second(xi,yi,theta,xf,yf,clk);
endmodule

/////////////////////////Rotation////////////////////////////////////////////////
module ROTATING(x0, y0, theta, xf, yf, clk);
  input clk;
  input [15:0] x0, y0;
  input [15:0] theta;
  output [15:0] xf, yf;
  wire [15:0] xi [0:7]; 
  wire [15:0] yi [0:7];
  reg [2:0] stage;
  wire [15:0] outangle [0:7];
  
  
  // instantiating
  
  //stage0
  cordics r0(clk, 3'd0, x0, y0, theta, 16'd45_00, 16'd0, xi[0], yi[0], outangle[0]);
  //stage1
  cordics r1(clk, 3'd1, xi[0], yi[0], theta, 16'd26_57, outangle[0], xi[1], yi[1], outangle[1]);
  //stage2
  cordics r2(clk, 3'd2, xi[1], yi[1], theta, 16'd14_04, outangle[1], xi[2], yi[2], outangle[2]); 
  //stage3
  cordics r3(clk, 3'd3, xi[2], yi[2], theta, 16'd7_13, outangle[2], xi[3], yi[3], outangle[3]);
  //stage4
  cordics r4(clk, 3'd4, xi[3], yi[3], theta, 16'd3_58, outangle[3], xi[4], yi[4], outangle[4]);  
  //stage5
  cordics r5(clk, 3'd5, xi[4], yi[4], theta, 16'd1_79, outangle[4], xi[5], yi[5], outangle[5]);
  //stage6
  cordics r6(clk, 3'd6, xi[5], yi[5], theta, 16'd89, outangle[5], xi[6], yi[6], outangle[6]);
  //stage7
  cordics r7(clk, 3'd7, xi[6], yi[6], theta, 16'd44, outangle[6], xi[7], yi[7], outangle[7]);
  assign xf = xi[7];
  assign yf = yi[7];
  // assign xf <= (xi[7]>>>1)+(xi[7]>>>4)+(xi[7]>>>5);
  //assign yf <= (yi[7]>>>1)+(yi[7]>>>4)+(yi[7]>>>5);
  
endmodule
  
  
module cordics(clk,stage,xi,yi,theta,uangle,inangle,xf,yf,outangle);
 input clk;
 input [2:0] stage;
 input [15:0] xi,yi,theta,inangle,uangle;
 output reg [15:0] xf,yf,outangle;

 always @(posedge clk)begin
   if((inangle)>theta)begin                                   //clockwise

    case({xi[15],yi[15]})
       2'b00 : begin
          xf <= xi+(yi>>stage);
            yf <= yi - (xi>>stage);
       end
       2'b01 : begin
          xf <= xi-((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) - (xi>>stage);
       end 
      2'b10 : begin
          xf <= -(16'hffff-xi+1)+(yi>>stage);
          yf <= yi +((16'hffff-xi+1)>>stage);
       end
      2'b11 : begin 
          xf <= -(16'hffff-xi+1)-((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) + ((16'hffff-xi+1)>>stage);
       end
    endcase
    outangle <= inangle-uangle;
   end
   
   else begin 
    case({xi[15],yi[15]})
       2'b00 : begin                                        //anticlockwise
          xf <= xi-(yi>>stage);
          yf <= yi + (xi>>stage);
        end
       2'b01 : begin
            xf <= xi + ((16'hffff-yi+1)>>stage);
            yf <= -(16'hffff-yi+1) + (xi>>stage);
        end 
       2'b10 : begin
          xf <= -((16'hffff-xi+1))-(yi>>stage);
          yf <= yi - ((16'hffff-xi+1)>>stage);
        end 
       2'b11 : begin
          xf <= -(16'hffff-xi+1)+((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) - ((16'hffff-xi+1)>>stage);
        end
    endcase
         outangle <= inangle+uangle;
   end
  end
endmodule

/////////////////////////Vectoring////////////////////////////////////////////////

module VECTORING(clk, xi, yi, theta, norm);
input clk;
input [15:0] xi, yi;
output [15:0] theta, norm;
reg [2:0] stage;
wire [15:0] x [0:7];
wire [15:0] y [0:7];
wire [15:0] outangle [0:7];

 //stage 0
   cordicvec v0(clk,3'd0,xi,yi,16'd0,x[0],y[0],outangle[0],16'd45_00);
 //stage 1
   cordicvec v1(clk,3'd1,x[0],y[0],outangle[0],x[1],y[1],outangle[1],16'd26_57); 
 //stage 2
   cordicvec v2(clk,3'd2,x[1],y[1],outangle[1],x[2],y[2],outangle[2],16'd14_04);
 //stage 3
   cordicvec v3(clk,3'd3,x[2],y[2],outangle[2],x[3],y[3],outangle[3],16'd7_13);
 //stage 4
   cordicvec v4(clk,3'd4,x[3],y[3],outangle[3],x[4],y[4],outangle[4],16'd3_58); 
 //stage 5
   cordicvec v5(clk,3'd5,x[4],y[4],outangle[4],x[5],y[5],outangle[5],16'd1_79); 
 //stage 6
   cordicvec v6(clk,3'd6,x[5],y[5],outangle[5],x[6],y[6],outangle[6],16'd89);
 //stage 7
   cordicvec v7(clk,3'd7,x[6],y[6],outangle[6],x[7],y[7],outangle[7],16'd44); 
   
    assign norm = x[7];
    assign theta = outangle[7];
  // assign xf = (x[7]>>>1)+(x[7]>>>4)+(x[7]>>>5);
   //assign yf = (y[7]>>>1)+(y[7]>>>4)+(y[7]>>>5);    
endmodule


module cordicvec (clk, stage, xi, yi, inangle, xf, yf, outangle, uangle);

input clk;
input [2:0] stage;
input [15:0] xi, yi, inangle, uangle;
output reg [15:0] xf, yf, outangle;

 always @(posedge clk)
 
 begin
 
  if (yi[15])
   begin
   case({xi[15],yi[15]})
       2'b00 : begin                              //anticlockwise
          xf <= xi-(yi>>stage);
          yf <= yi + (xi>>stage);
        end
       2'b01 : begin
            xf <= xi + ((16'hffff-yi+1)>>stage);
            yf <= -(16'hffff-yi+1) + (xi>>stage);
        end 
       2'b10 : begin
          xf <= -((16'hffff-xi+1))-(yi>>stage);
          yf <= yi - ((16'hffff-xi+1)>>stage);
        end 
       2'b11 : begin
          xf <= -(16'hffff-xi+1)+((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) - ((16'hffff-xi+1)>>stage);
        end
    endcase
         outangle <= inangle-uangle;
   end

     else begin                                    //clockwise
    case({xi[15],yi[15]})
       2'b00 : begin
          xf <= xi+(yi>>stage);
            yf <= yi - (xi>>stage);
       end
       2'b01 : begin
          xf <= xi-((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) - (xi>>stage);
       end 
      2'b10 : begin
          xf <= -(16'hffff-xi+1)+(yi>>stage);
          yf <= yi +((16'hffff-xi+1)>>stage);
       end
      2'b11 : begin 
          xf <= -(16'hffff-xi+1)-((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) + ((16'hffff-xi+1)>>stage);
       end
    endcase
    outangle <= inangle+uangle;
   end
 end
 endmodule
 ```
 ## TESTBENCH
 ```verilog
 module ROTATING_VECTORING_TB #(parameter period=5);
  reg clk=0;
  reg [15:0]xi,yi;
  wire [15:0]xf,yf;
  always @(*)begin
    #period clk<=~clk;
    end
  ROTATING_VECTORING dut(clk,xi,yi,xf,yf);
  initial begin
    {xi,yi}={16'd20, 16'd20};
   end
endmodule
```
## SIMULATION OUTPUT of ROTATING_VECTORING

![image](https://user-images.githubusercontent.com/120499567/234987501-558a769c-030f-498f-af80-087cc7d60854.png)
## SYNTHESIS of ROTATING_VECTORING using GENUS

![6](https://user-images.githubusercontent.com/120499567/235062631-1cffaeb8-20b9-43b6-a81e-d4d3155d268c.png)

![1](https://user-images.githubusercontent.com/120499567/235062740-72ab962b-c19e-4aea-89d9-8b1c4da9e820.png)

![2](https://user-images.githubusercontent.com/120499567/235062853-bc4a0e7e-da86-4f6e-a4fd-dcfb6f6851f1.png)
![3](https://user-images.githubusercontent.com/120499567/235062932-fa29a225-51f2-4f91-bcac-63f5b92e5a6d.png)


# Doubly Pipeline in Rotating and Vectoring based Design Methodology CORDIC
# code 
```verilog
module DOUBLY_PIPELINE(clk,xi,yi,xf,yf);
 input clk;
 input [15:0]xi,yi; 
 output [15:0] xf,yf;
 wire [15:0]theta,R;
 wire [7:0]dir;
 VECTORING first(clk,xi,yi,theta,R,dir);
 ROTATING second(clk,dir,xi,yi,theta,xf,yf);
endmodule

module ROTATING(clk,dir,xi,yi,theta,xf,yf);
 input clk;
 input [15:0]xi,yi;
 input [15:0] theta;
 input dir[7:0];
 output [15:0] xf,yf;  
 reg[2:0]stage;
 wire [15:0]x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8;
   wire [15:0]outangle0,outangle1,outangle2,outangle3,outangle4,outangle5,outangle6,outangle7;
 //stage 0
   itteration_rot i0(clk,dir[0],3'd0,xi,yi,16'd0,theta,16'd45_00,x1,y1,outangle0);
 //stage 1
   itteration_rot i1(clk,dir[1],3'd1,x1,y1,outangle0,theta,16'd26_57,x2,y2,outangle1); 
 //stage 2
   itteration_rot i2(clk,dir[2],3'd2,x2,y2,outangle1,theta,16'd14_04,x3,y3,outangle2);
 //stage 3
   itteration_rot i3(clk,dir[3],3'd3,x3,y3,outangle2,theta,16'd7_13,x4,y4,outangle3);
 //stage 4
   itteration_rot i4(clk,dir[4],3'd4,x4,y4,outangle3,theta,16'd3_58,x5,y5,outangle4); 
 //stage 5
   itteration_rot i5(clk,dir[5],3'd5,x5,y5,outangle4,theta,16'd1_79,x6,y6,outangle5);
 //stage 6
   itteration_rot i6(clk,dir[6],3'd6,x6,y6,outangle5,theta,16'd89,x7,y7,outangle6);
 //stage 7
   itteration_rot i7(clk,dir[7],3'd7,x7,y7,outangle6,theta,16'd44,x8,y8,outangle7); 
   
    assign xf=x8;
    assign yf=y8;
  // assign xf = (x8>>>1)+(x8>>>4)+(x8>>>5);
   //assign yf = (y8>>>1)+(y8>>>4)+(y8>>>5);    
 endmodule
  
 

module itteration_rot(clk,dir_stage,stage,xi,yi,initial_angle,theta,micro_angle,xf,yf,out_angle);
 input clk;
 input [2:0] stage;
 input dir_stage;
  input [15:0]xi,yi,theta,initial_angle,micro_angle;
  output reg [15:0] xf,yf,out_angle;

 always @(posedge clk)begin
   if(!dir_stage)begin     //clockwise

    case({xi[15],yi[15]})
       2'b00 : begin
          xf <= xi+(yi>>stage);
            yf <= yi - (xi>>stage);
       end
       2'b01 : begin
          xf <= xi-((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) - (xi>>stage);
       end 
      2'b10 : begin
          xf <= -(16'hffff-xi+1)+(yi>>stage);
          yf <= yi +((16'hffff-xi+1)>>stage);
       end
      2'b11 : begin 
          xf <= -(16'hffff-xi+1)-((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) + ((16'hffff-xi+1)>>stage);
       end
    endcase
    out_angle <= -micro_angle+initial_angle;
   end
   
   else begin 
    case({xi[15],yi[15]})
       2'b00 : begin                              //anticlockwise
          xf <= xi-(yi>>stage);
          yf <= yi + (xi>>stage);
        end
       2'b01 : begin
            xf <= xi + ((16'hffff-yi+1)>>stage);
            yf <= -(16'hffff-yi+1) + (xi>>stage);
        end 
       2'b10 : begin
          xf <= -((16'hffff-xi+1))-(yi>>stage);
          yf <= yi - ((16'hffff-xi+1)>>stage);
        end 
       2'b11 : begin
          xf <= -(16'hffff-xi+1)+((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) - ((16'hffff-xi+1)>>stage);
        end
    endcase
         out_angle <= initial_angle+micro_angle;
   end
   end
   endmodule

module ROTATING(clk,xi,yi,theta,R,dir);
 input clk;
 input [15:0]xi,yi;
 output [15:0] R,theta;
 output reg dir[7:0];  
 reg[2:0]stage;
 wire dir0,dir1,dir2,dir3,dir4,dir5,dir6,dir7;
 wire [15:0]x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8;
 wire [15:0]outangle0,outangle1,outangle2,outangle3,outangle4,outangle5,outangle6,outangle7;
 //stage 0
   itteration_vec i0(clk,3'd0,xi,yi,16'd0,16'd45_00,x1,y1,outangle0,dir0);
 //stage 1
   itteration_vec i1(clk,3'd1,x1,y1,outangle0,16'd26_57,x2,y2,outangle1,dir1); 
 //stage 2
   itteration_vec i2(clk,3'd2,x2,y2,outangle1,16'd14_04,x3,y3,outangle2,dir2);
 //stage 3
   itteration_vec i3(clk,3'd3,x3,y3,outangle2,16'd7_13,x4,y4,outangle3,dir3);
 //stage 4
   itteration_vec i4(clk,3'd4,x4,y4,outangle3,16'd3_58,x5,y5,outangle4,dir4); 
 //stage 5
   itteration_vec i5(clk,3'd5,x5,y5,outangle4,16'd1_79,x6,y6,outangle5,dir5); 
 //stage 6
   itteration_vec i6(clk,3'd6,x6,y6,outangle5,16'd89,x7,y7,outangle6,dir6);
 //stage 7
   itteration_vec i7(clk,3'd7,x7,y7,outangle6,16'd44,x8,y8,outangle7,dir7); 

    assign dir[0] = dir0;
    assign dir[1] = dir1;
    assign dir[2] = dir2;
    assign dir[3] = dir3;
    assign dir[4] = dir4;
    assign dir[5] = dir5;
    assign dir[6] = dir6;
    assign dir[7] = dir7;
  
    assign R = x8;
    assign theta = outangle7;
  // assign xf = (x8>>>1)+(x8>>>4)+(x8>>>5);
   //assign yf = (y8>>>1)+(y8>>>4)+(y8>>>5);    
 endmodule
  
module itteration_vec(clk,stage,xi,yi,initial_angle,micro_angle,xf,yf,out_angle,dir_stage);
 input clk;
 input [2:0] stage;
  input [15:0]xi,yi,initial_angle,micro_angle;
  output reg [15:0] xf,yf,out_angle;
  output reg dir_stage;

 //assign micro_angle[7:0] ={16'd448,16'd895,16'd1790,16'd3580,16'd7130,16'd14040,16'd26570,16'd45000};
 
 always @(posedge clk)begin
  
   if (yi[15])begin 
    case({xi[15],yi[15]})
       2'b00 : begin                              //anticlockwise
          xf <= xi-(yi>>stage);
          yf <= yi + (xi>>stage);
        end
       2'b01 : begin
            xf <= xi + ((16'hffff-yi+1)>>stage);
            yf <= -(16'hffff-yi+1) + (xi>>stage);
        end 
       2'b10 : begin
          xf <= -((16'hffff-xi+1))-(yi>>stage);
          yf <= yi - ((16'hffff-xi+1)>>stage);
        end 
       2'b11 : begin
          xf <= -(16'hffff-xi+1)+((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) - ((16'hffff-xi+1)>>stage);
        end
    endcase
         out_angle <= initial_angle-micro_angle;
         dir_stage <=1;
   end

     else begin        //clockwise
    case({xi[15],yi[15]})
       2'b00 : begin
          xf <= xi+(yi>>stage);
            yf <= yi - (xi>>stage);
       end
       2'b01 : begin
          xf <= xi-((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) - (xi>>stage);
       end 
      2'b10 : begin
          xf <= -(16'hffff-xi+1)+(yi>>stage);
          yf <= yi +((16'hffff-xi+1)>>stage);
       end
      2'b11 : begin 
          xf <= -(16'hffff-xi+1)-((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) + ((16'hffff-xi+1)>>stage);
       end
    endcase
    out_angle <= micro_angle+initial_angle;
    dir_stage <=0;
   end

   end
   endmodule
   ```
   # testbench
   ```verilog
   module ROTATING_VECTORING_TB #(parameter period=5);
  reg clk=0;
  reg [15:0]xi,yi;
  wire [15:0]xf,yf;
  always @(*)begin
    #period clk<=~clk;
    end
  double_pipe dut(clk,xi,yi,xf,yf);
  initial begin
    {xi,yi}={16'd20, 16'd20};
   end
   ```
   # SIMULATION OUTPUT of DOUBLY PIPELINE
   
endmodule






   
   
   
   
   
