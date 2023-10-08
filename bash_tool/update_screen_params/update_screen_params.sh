#!/bin/bash 

#offset 0x91A0 (37280)
#设计固化区域 0x20 * 0x200 = 0x4000
#生产固化区域 0x10 * 0x200 = 0x2000

#0x10020~0x1002F
dd if=metazone_new.bin of=metazone.head bs=1 skip=53664
dd if=metazone.head of=screen_params.bin bs=1 count=8192


dd if=metazone.bin of=metazone.head bs=1 count=53664
#dd if=metazone.bin of=metazone.head bs=1 count=54176
dd if=metazone.bin of=metazone.tail bs=1 skip=61856

cat metazone.head screen_params.bin metazone.tail > metazone.result

rm metazone.head screen_params.bin metazone.tail
