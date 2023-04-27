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
