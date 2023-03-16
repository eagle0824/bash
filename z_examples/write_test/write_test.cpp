#include "stdio.h"
#include <stdlib.h>
#include <string>
#include <iostream>

using namespace std;

int main(int argc, char *argv[])
{
//if (argc != 2){
//        return -1; 
//    }

    string str("good good study, day day up");

    string data = "good good";

    string::size_type pos = string::npos;
    printf("str ===> %s\n", str.c_str());
    do {
       pos = str.find(data);
       if (pos !=  string::npos) {
            str.replace(pos, string(data).length(), "aa");
       }
    } while(pos !=  string::npos);

    printf("str ===> %s\n", str.c_str());
    //char* path = argv[1];
    //char* text = argv[2];
    //printf("argc  %s, %s\n", path, text);
    //FILE *file;//定义文件流指针，用于打开读取的文件
    //file = fopen(path,"w");
    //puts(text);
    //fputs(text,file);
    //fclose(file);
}
