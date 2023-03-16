#include "stdio.h"
#include <stdlib.h>

main(int argc, char *argv[])
{
    if (argc != 2){
        return; 
    }
    char* path = argv[1];
    char* text = argv[2];
    printf("argc  %s, %s\n", path, text);
    FILE *file;//定义文件流指针，用于打开读取的文件
    file = fopen(path,"w");
    puts(text);
    fputs(text,file);
    fclose(file);
}
