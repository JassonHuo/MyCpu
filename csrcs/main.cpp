#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <Vtop.h>
#include <verilated.h>
#include <verilated_fst_c.h>


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
  contextp->commandArgs(argc, argv);
  top->clk = 0;
  top->rst = 0;

  contextp->traceEverOn(true);
  top->trace(tfp, 99);
  tfp->open("cpu_wave.fst");

/*  top->rst = 1;
  for (int i = 0; i < 10; i ++)
  {
	one_cycle();
  }
  top->rst = 0;
  top->clk = 0;
*/
  int cycle = 7000;

  while(cycle)
  {
	contextp->timeInc(1);
	one_cycle();
	cycle --;
//	printf("%d: %d\n", 7000 - cycle, top->pc);
  }
  tfp->close();
  top->final();
  delete top;
  top = nullptr;
  delete contextp;
  contextp = nullptr;
  return 0;
}
