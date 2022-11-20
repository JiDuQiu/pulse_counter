// 脉冲计数器
`timescale 1ns/1ps
module pulse_counter(
	input i_clk,            //时钟输入
	input i_rst_n,          //复位信号
	input i_pulse,          //脉冲信号输入（长短的脉冲）
	input i_en,             //使能信号
	output reg[15:0] o_pulse_cnt                //脉冲计数输出
    );
 
reg[1:0] r_pulse;       //与i_pulse相关的脉冲
wire w_rise_edge;       //脉冲信号（构造的一个极短的脉冲信号）
 
//
//脉冲边沿检测逻辑
 
always @(posedge i_clk)	
	if(!i_rst_n) r_pulse <= 2'b00;
	else r_pulse <= {r_pulse[0],i_pulse};     //r_pulse[1]比r_pulse[0]慢一个时钟周期
 
assign w_rise_edge = r_pulse[0] & ~r_pulse[1];	//每个i_pulse上升沿的时候就会有这一个这个脉冲；
 
//
//脉冲计数逻辑
 
always @(posedge i_clk)	
	if(i_en) begin
		if(w_rise_edge) o_pulse_cnt <= o_pulse_cnt+1;
		else /*o_pulse_cnt <= o_pulse_cnt*/;
	end
	else o_pulse_cnt <= 'b0;
 
 
endmodule
 
