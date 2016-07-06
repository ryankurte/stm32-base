#include <stdint.h>
#include <stdlib.h>

#include <stdio.h>

int _write_r(struct _reent *r, int fd, const void *data, unsigned int count)
{
    return 0;
}

int main(void)
{

    volatile int a = 0;

    printf("test\r\n");

    while(1) {
        a ++;
    }

}

