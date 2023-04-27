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
module rotation_mode_4 #(parameter N=32)(
    input  signed [N-1:0] x0, y0,
    input  signed [17:0] angle,
    input  clk,
    output signed [N-1:0] xf, yf
    );
   
    //Micro-angles storing in reg. multipled by 1000
    reg signed [17:0] reg_angle [0:N-1];
    initial begin reg_angle[0] = 45000; reg_angle[1] = 26565; reg_angle[2] = 14036; reg_angle[3] = 7125; //3-digit decimal
                  reg_angle[4] = 03576; reg_angle[5] = 01790; reg_angle[6] = 00895; reg_angle[7] = 0448;
                  reg_angle[8] = 00224; reg_angle[9] = 00112; reg_angle[10]= 00056; reg_angle[11]= 0028;
                  reg_angle[12]= 00014; reg_angle[13]= 00007; reg_angle[14]= 00003; reg_angle[15]= 0002;
            end
     
    //Other variables            
    reg signed [17:0] angle_new;      

    integer i;
   
    reg signed [N-1:0] x [0:N];
    reg signed [N-1:0] y [0:N];
    //reg signed [N-1:0] x, y;
   
    //Final output x[16]*0.607 --> 0.607=b0.10011011011
    //assign xf=(((x[16])>>1)+((x[16])>>4)+((x[16])>>5)+((x[16])>>7)+((x[16])>>8)+((x[16])>>10));
    //assign yf=(((y[16])>>1)+((y[16])>>4)+((y[16])>>5)+((y[16])>>7)+((y[16])>>8)+((y[16])>>10));
   
    assign xf=x[16]*0.607;
    assign yf=y[16]*0.607;
   
    always @ (posedge clk) begin
        angle_new = reg_angle[0];
        //+45 for 1st stage
        x[1] = x0 + y0;
        y[1] = y0 - x0;
        //x = x0 + y0;
        //y = y0 - x0;
       
        for (i=1;i<=15;i=i+1) begin
            if (angle_new < angle) begin  
               x[i+1] = x[i] + (y[i]>>>i);
               y[i+1] = y[i] - (x[i]>>>i);
//               x = x + (y>>>i);
//               y = y - (x>>>i);
               angle_new = angle_new + reg_angle[i];
            end
            else begin
               x[i+1] = x[i] - (y[i]>>>i);
               y[i+1] = y[i] + (x[i]>>>i);
//               x = x - (y>>>i);
//               y = y + (x>>>i);
               angle_new = angle_new - reg_angle[i];
            end
        end
    end
endmodule
```
# Testbench
```verilog
module test_rotation_mode();
    parameter N=32;
    reg  signed [N-1:0] x0, y0;
    reg  signed [17:0] angle;
    reg clk;
    wire [N-1:0] xf, yf;
   
    rotation_mode_4 uut (x0, y0, angle, clk, xf, yf);

    always #5 clk=~clk;
   
    initial begin
        clk=0;
        x0=30_000; y0=40_000;
       
        angle=53_000; #10;
//        angle=30_000; #10;
//        angle=45_000; #10;
//        angle=60_000; #10;
//        angle=75_000; #10;
//        angle=90_000; #10;
        //x0=1000; y0=9000; angle=10000; #10;
        //$finish;
    end
endmodule
```
# Simulation output of rotating
![image](https://user-images.githubusercontent.com/120499567/234943006-7668987a-844c-450f-9ee4-b363a337281e.png)


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

   
   
   
   
   
