屏幕参数在metazone中的位置 0x10020~0x1002F
16 * 512 = 8192 的数据

#offset 0x91A0 (37280)
#设计固化区域 0x20 * 0x200 = 0x4000
0x91a0+200*20 = D1A0 (53664)

1 metazone.bin是需要更新屏参数的metazone
2 metazone_new.bin 待ok的屏幕参数的metazone
3 screen_params.bin 是0x10020~0x1002F的屏参数据 
4 metazone.result 是更新屏参之后的metazone 
