#include "types.h"
#include "stat.h"
#include "fs.h"
#include "fcntl.h"
#include "syscall.h"
#include "user.h"

#define BUFFER_SIZE 5

void
producer()
{
  int in = 0;
  while (1)
  {
    /*
      Produce an item.
    */
    while (get_counter() == BUFFER_SIZE)
    ; // Wait

    /*
      Update shared memory.
    */
    in = (in + 1) % BUFFER_SIZE;

    semaphore_aquire(1);
    printf(2, "Producer aquired lock\n");
    inc_counter();
    semaphore_release(1);
    printf(2, "Producer released lock\n");

    sleep(500);
  }
}

void
consumer()
{
  int out = 0;
  while (1)
  {
    while (get_counter() == 0)
    ; // Wait
    /*
      Update shared memory.
    */
    out = (out + 1) % BUFFER_SIZE;

    semaphore_aquire(1);
    printf(2, "Consumer aquired lock\n");
    dec_counter();
    semaphore_release(1);
    printf(2, "Consumer released lock\n");

    /*
      Consume an item.
    */
    sleep(500);
  }
}

int
main(int argc, char *argv[])
{
  semaphore_initialize(1, 1, 0);
  int pid = fork();
  
  // Let child be producer
  if (pid == 0)
    producer();
  else
    consumer();

  wait();
  exit();

/*  semaphore_initialize(1,1,0);
  fork();
  fork();
  semaphore_aquire(1);
  printf(2, "salaaaaaaaaaam\n");
  sleep(100);
  semaphore_release(1);
  wait();
  wait();  
  exit();*/
}