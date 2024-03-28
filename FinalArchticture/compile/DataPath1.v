//-----------------------------------------------------------------------------
//
// Title       : No Title
// Design      : FinalArchticture
// Author      : Dohaa
// Company     : Birziet University
//
//-----------------------------------------------------------------------------
//
// File        : C:\My_Designs\FinalArchProject\FinalArchticture\compile\DataPath1.v
// Generated   : Sun Jan 21 00:30:32 2024
// From        : C:\My_Designs\FinalArchProject\FinalArchticture\src\DataPath1.bde
// By          : Bde2Verilog ver. 2.01
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------

`ifdef _VCP
`else
`define library(a,b)
`endif


// ---------- Design Unit Header ---------- //
`timescale 1ps / 1ps

module DataPath1 (Rs1,Rs2,Rd,Imm,Mode,OPcode,WBRd,PC,clock) ;

// ------------ Port declarations --------- //
input Rs1;
wire Rs1;
input Rs2;
wire Rs2;
input Rd;
wire Rd;
input Imm;
wire Imm;
input Mode;
wire Mode;
input OPcode;
wire OPcode;
output WBRd;
wire WBRd;
input PC;
wire PC;
input clock;
wire clock;

// ----------------- Constants ------------ //
parameter DANGLING_INPUT_CONSTANT = 1'bZ;

// ----------- Signal declarations -------- //
supply0 GND;
wire NET417;
wire NET5762;
wire NET5789;
wire NET605;
wire NET6123;
wire NET625;
wire NET6603;
wire NET7309;
wire NET7327;
wire NET8110;
wire [7:0] BUS1609;
wire [7:0] BUS1960;
wire [1:0] BUS3118;
wire [7:0] BUS3383;
wire [31:0] BUS4353;
wire [1:0] BUS4444;
wire [31:0] BUS5368;
wire [31:0] BUS5986;
wire [31:0] BUS6117;
wire [31:0] BUS6426;
wire [31:0] BUS6552;
wire [31:0] BUS6719;
wire [31:0] BUS6739;
wire [5:0] BUS6846;
wire [1:0] BUS6883;
wire [31:0] BUS7286;
wire [31:0] BUS7462;
wire [31:0] BUS7501;
wire [31:0] BUS7576;
wire [31:0] BUS7589;
wire [31:0] BUS7898;
wire [31:0] BUS7906;
wire [31:0] BUS7910;

// ---- Declaration for Dangling inputs ----//
wire Dangling_Input_Signal = DANGLING_INPUT_CONSTANT;

// -------- Component instantiations -------//

Adder U10
(
	.x({PC,{31{Dangling_Input_Signal}}}),
	.y({BUS1960[7:0],{24{Dangling_Input_Signal}}}),
	.address(BUS7589[31])
);



mux2x1 U11
(
	.x({BUS3383[7:0],{24{Dangling_Input_Signal}}}),
	.y(BUS6739),
	.s(NET6123),
	.z(BUS6117)
);



StackPointer U12
(
	.new_top(BUS6426),
	.clk(NET8110),
	.top(BUS6739)
);



Incrementer U13
(
	.in(BUS6739),
	.out(BUS7286)
);



mux4x1 U14
(
	.a1(BUS7286),
	.a2(BUS6552),
	.a3(BUS6739),
	.a4(BUS6719),
	.s({NET6603,Dangling_Input_Signal}),
	.z(BUS6426)
);



decrementer U15
(
	.in(BUS6739),
	.out(BUS6552)
);



MainControlUnit U16
(
	.OpCode(BUS6846),
	.ALUSrc(BUS4444),
	.RdWB(BUS6883),
	.ExtOp(NET625),
	.MemWr(NET605),
	.MemRd(NET625),
	.MemIn(NET5789),
	.MemAddress(NET6123),
	.STop(NET6603)
);



EX_MA_Buffer U17
(
	.clk(NET8110),
	.ALU_RESULT({BUS3383[7:0],{24{Dangling_Input_Signal}}}),
	.ZERO_FLAG(NET7309),
	.CARRY_FLAG(NET7327),
	.NEW_RS1(BUS7462),
	.RD({NET5762,{31{Dangling_Input_Signal}}}),
	.NEXT_PC(BUS7589),
	.pALU_RESULT(BUS3383[7:0]),
	.pZERO_FLAG(),
	.pCARRY_FLAG(),
	.pNEW_RS1(),
	.pRD(BUS7501),
	.pNEXT_PC(BUS7576)
);



MA_WB_Buffer U18
(
	.clk(NET8110),
	.ALU_RESULT({BUS3383[7:0],{24{Dangling_Input_Signal}}}),
	.MEMORY_RESULT(BUS7898),
	.pALU_RESULT(BUS7906),
	.pMEMORY_RESULT(BUS7910)
);



ALU32 U2
(
	.X({Rs1,{31{Dangling_Input_Signal}}}),
	.Y(BUS4353),
	.AluOp(BUS3118),
	.Z(BUS3383[7:0]),
	.ZeroFlag(NET7309),
	.CarryFlag(NET7327)
);



// synthesis translate_off
`library("U3","my_design")
// synthesis translate_on
Extender U3
(
	.in({Imm,{16{Dangling_Input_Signal}}}),
	.out(BUS1960[7:0]),
	.ExtOp(NET625)
);



ALU32_control U4
(
	.OpCode({NET417,{5{Dangling_Input_Signal}}}),
	.AluOp(BUS3118)
);



mux4x1 U5
(
	.a1({Rs2,{31{Dangling_Input_Signal}}}),
	.a2({BUS1960[7:0],{24{Dangling_Input_Signal}}}),
	.a3(BUS5368),
	.a4({GND,{31{Dangling_Input_Signal}}}),
	.s(BUS4444),
	.z(BUS4353)
);



DataMemory U6
(
	.address(BUS6117),
	.data_in(BUS5986),
	.clk(NET8110),
	.MemWr(NET605),
	.MemRd(NET625),
	.data_out(BUS7898)
);



mux2x1 U7
(
	.x(BUS7501),
	.y(BUS7576),
	.s(NET5789),
	.z(BUS5986)
);



mux2x1 U8
(
	.x(BUS7906),
	.y(BUS7910),
	.s(BUS6883[1]),
	.z(WBRd)
);



Incrementer U9
(
	.in({BUS1609[7:0],{24{Dangling_Input_Signal}}}),
	.out(BUS7462)
);



// ----------- Terminals assignment --------//
//	       ---- Input terminals ---         //
assign NET5762 = Rd;
assign NET417 = OPcode;
assign NET8110 = clock;

// ------------- Ground assignment ---------//
assign BUS6719[0] = GND;
assign BUS6719[10] = GND;
assign BUS6719[11] = GND;
assign BUS6719[12] = GND;
assign BUS6719[13] = GND;
assign BUS6719[14] = GND;
assign BUS6719[15] = GND;
assign BUS6719[16] = GND;
assign BUS6719[17] = GND;
assign BUS6719[18] = GND;
assign BUS6719[19] = GND;
assign BUS6719[1] = GND;
assign BUS6719[20] = GND;
assign BUS6719[21] = GND;
assign BUS6719[22] = GND;
assign BUS6719[23] = GND;
assign BUS6719[24] = GND;
assign BUS6719[25] = GND;
assign BUS6719[26] = GND;
assign BUS6719[27] = GND;
assign BUS6719[28] = GND;
assign BUS6719[29] = GND;
assign BUS6719[2] = GND;
assign BUS6719[30] = GND;
assign BUS6719[31] = GND;
assign BUS6719[3] = GND;
assign BUS6719[4] = GND;
assign BUS6719[5] = GND;
assign BUS6719[6] = GND;
assign BUS6719[7] = GND;
assign BUS6719[8] = GND;
assign BUS6719[9] = GND;

endmodule 
