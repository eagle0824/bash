#!/bin/bash

#默认参数
#index 10039        16进制 offset = 91A0 + 200 * 39 = 103A0 = 66464
#dd if=metazone.bin of=metazone.head bs=1 count=66468 #offset+4
#dd if=metazone.bin of=metazone.tail bs=1 skip=66976  #offset+512
#cat metazone.head DynamicTrack.bin metazone.tail > metazone.result

#index 10040 1024x600 16进制 offset = 91A0 + 200 * 40 = 111A0 = 70048
#dd if=metazone.bin of=metazone.head bs=1 count=70052 #offset+4
#dd if=metazone.bin of=metazone.tail bs=1 skip=70560  #offset+512
#cat metazone.head DynamicTrack.bin metazone.tail > metazone.result

#index 10041 1280x720 16进制 offset = 91A0 + 200 * 41 = 113A0 = 70560
#dd if=metazone.bin of=metazone.head bs=1 count=70564 #offset+4
#dd if=metazone.bin of=metazone.tail bs=1 skip=71072  #offset+512
#cat metazone.head DynamicTrack.bin metazone.tail > metazone.result

#index 10042 1280x800 16进制 offset = 91A0 + 200 * 42 = 115A0 = 71072
dd if=metazone.bin of=metazone.head bs=1 count=71076 #offset+4
dd if=metazone.bin of=metazone.tail bs=1 skip=71584  #offset+512
cat metazone.head DynamicTrack_1280x800.bin metazone.tail > metazone.bin

#index 10043 1600x720 16进制 offset = 91A0 + 200 * 43 = 117A0 = 71584
dd if=metazone.bin of=metazone.head bs=1 count=71588 #offset+4
dd if=metazone.bin of=metazone.tail bs=1 skip=72096  #offset+512
cat metazone.head DynamicTrack_1600x720.bin metazone.tail > metazone.bin

#index 10044 1920x720 16进制 offset = 91A0 + 200 * 44 = 119A0 = 72096
dd if=metazone.bin of=metazone.head bs=1 count=72100 #offset+4
dd if=metazone.bin of=metazone.tail bs=1 skip=72608  #offset+512
cat metazone.head DynamicTrack_1920x720.bin metazone.tail > metazone.bin
