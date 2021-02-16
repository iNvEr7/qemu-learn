#include <stdio.h>
#include <stdlib.h>

int main(int argc, const char *args[argc])
{
    printf("Hello World!\n");
    int i;
    for (i = 0; i < argc; i++) {
        printf("arg%d=%s\n", i, args[i]);
    }
    return 233;
}
