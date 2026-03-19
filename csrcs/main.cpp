#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <Vtop.h>
#include <verilated.h>
#include <verilated_fst_c.h>
#include <string.h>
#include <stdint.h>
#include <iostream>
#include <fstream>
#include <Vtop___024root.h>
#include <sys/stat.h>
//#include <Vtop_gpr.h>
//#include <Vtop_rom.h>
//#include <Vtop_top.h>


VerilatedContext *contextp = new VerilatedContext;

Vtop *top = new Vtop{contextp};

VerilatedFstC *tfp = new VerilatedFstC;

void one_cycle()
{
  top->clk = 0;
  top->eval();
  tfp->dump(contextp->time());
  contextp->timeInc(1);
  top->clk = 1;
  top->eval();
  tfp->dump(contextp->time());
  contextp->timeInc(1);
}


int main(int argc, char **argv)
{

  if(argc == 1)
  {
	printf("you must input a program\n");
	exit(1);
  }
  std::string program = argv[1];
  contextp->commandArgs(argc, argv);
  std::ifstream file(program);
  std::string line;
  int addr = 0;
  while(std::getline(file, line))
  {
	if(line.empty() || line[0] == '#' || line.substr(0, 2) == "//") continue;
	uint32_t code = std::stoul(line, nullptr, 16);
	if(addr <= 131072) top->rootp->top__DOT__rom0__DOT__rom_reg[addr++] = code;
	else
	{
	  std::cout << "too many codes!!!" << std::endl;
	  exit(1);
	}
  }
  top->clk = 0;
  top->rst = 0;

  contextp->traceEverOn(true);
  top->trace(tfp, 99);
  mkdir("waves", 0777);
  size_t pos = program.find_last_of("/\\");
  std::string file_name;
  if(pos == std::string::npos) file_name = program;
  else file_name = program.substr(pos + 1);
  std::string wave_name = "waves/" + file_name.substr(0, file_name.find_last_of('.'))+ "_wave.fst";
  std::cout << "Processing " << file_name;
  tfp->open(wave_name.c_str());

  int cycle = 10000;
  bool pass;
  while(cycle)
  {
	contextp->timeInc(1);
	one_cycle();
//	printf("%d: %d\n", 7000 - cycle, top->pc);
	cycle--;	
	if(top->rootp->top__DOT__gpr0__DOT__gpr_reg[3] == 1 && top->rootp->top__DOT__gpr0__DOT__gpr_reg[17] == 93 && top->rootp->top__DOT__gpr0__DOT__gpr_reg[10] == 0)
	{
	  std::cout << "\tPass";
	  pass = true;
	  break;
	}
  }
  if(!cycle || top->rootp->top__DOT__gpr0__DOT__gpr_reg[3] != 1 || top->rootp->top__DOT__gpr0__DOT__gpr_reg[17] != 93 || top->rootp->top__DOT__gpr0__DOT__gpr_reg[10] != 0)
  {
	std::cout << "\tFall";
	pass = false;
  }
  std::cout << "\t" << wave_name << std::endl;
  tfp->close();
  top->final();
  delete top;
  top = nullptr;
  delete contextp;
  contextp = nullptr;
  if(pass) return 0;
  else return 1;
}
