/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_Nithin574 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
    reg [7:0] uo_out_temp;
    reg clk_25Mhz;
    
    always@(posedge clk, negedge rst_n) begin
        if(!rst_n)begin
            //uo_out_temp <= 8'd0;
            clk_25Mhz <= 1'b0;
            end else begin
           // uo_out_temp  <= ui_in[5:0] + uio_in[5:0];  // Example: ou_out is the sum of ui_in and uio_in
            clk_25Mhz <= clk_25Mhz + 1'b1;
            end
    end

    always@(posedge clk_25Mhz, negedge rst_n)begin
        if(!rst_n)begin
              uo_out_temp <= 8'd0;
            //clk_25Mhz <= 1'b0;
            end else begin
                uo_out_temp  <= ui_in[6:0] + uio_in[6:0];  // Example: ou_out is the sum of ui_in and uio_in
            //clk_25Mhz <= clk_25Mhz + 1'b1;
            end
    end
   
    assign uo_out[7:0] = uo_out_temp;
    
    
    assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
    wire _unused = &{ena,ui_in[7],uio_in[7], 1'b0};

endmodule
