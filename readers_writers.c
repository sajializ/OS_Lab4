#include "types.h"
#include "stat.h"
#include "fs.h"
#include "fcntl.h"
#include "syscall.h"
#include "user.h"

void
readers_writers(){

  reset_counter();
  for (int i = 0; i < 6; i++){
      int pid = fork();
      if (pid == 0){

        // Writers
        if (i == 0 || i == 4){
            printf(1, "Child %d Executing as a writer\n", i + 1);
            // wait(rw_mutex);
            
            // Writing ...

            // signal(rw_mutex);
        }

        // Readers
        if (i != 0 && i != 4){
            printf(1, "Child %d Executing as a reader\n", i + 1);
            // wait(mutex);
            // inc_counter();
            // if (get_counter() == 1)
            //   wait(rw_mutex);
            // signal(mutex);

            // Reading ...

            // wait(mutex);
            // dec_counter();
            // if (get_counter() == 0)
            //   signal(rw_mutex);
            // signal(mutex)
        }

        exit();
      }
  }
  for (int i = 0; i < 6; i++)
    wait();
}

int
main(int argc, char *argv[]){
  readers_writers();
  exit();
}
