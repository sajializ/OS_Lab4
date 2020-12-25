#include "types.h"
#include "stat.h"
#include "fs.h"
#include "fcntl.h"
#include "syscall.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  semaphore_initialize(1,1,0);
  fork();
  fork();
  semaphore_aquire(1);
  printf(2, "salaaaaaaaaaam\n");
  sleep(100);
  semaphore_release(1);
  wait();
  wait();  
  exit();
}