#!/bin/sh

find \( -path './out' -o -path './.repo' -o -path './tools' -o -path './repo' -o -path './sdk' -o -path './prebuilts' -o -path './platform_testing' -o -path './projectFilesBackup' -o -path './release_images' -o -path './developers' -o -path './cts' -o -path './test' -o -path './testSuite' -o -path './toolchain' -o -path './pdk' \) -prune -o -type f -a \( -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.java" -o -name "*.mk" -o -name "*.xml" -o -name "*.cpp" -o -name "*.sh" -o -name "*.aidl" \) -print > cscope.files
cscope -bq
