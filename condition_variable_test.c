#include "types.h"
#include "stat.h"
#include "fs.h"
#include "fcntl.h"
#include "syscall.h"
#include "user.h"

void
test(){
  int pid = fork();
  if (pid < 0){
    printf(1, "Error forking first child.\n");
  }
  else if (pid == 0){
    printf(1, "Child 1 Executing\n");
  }
  else{
    int pid = fork();
    if (pid < 0){
        printf(1, "Error forking first child.\n");
    }
    else if (pid == 0){
        printf(1, "Child 2 Executing\n");
    }
    else{
      int i = 0;
      for (i = 0; i < 2; i++)
        wait();
    }
  }
}

int
main(int argc, char *argv[]){
  test();
  exit();
}