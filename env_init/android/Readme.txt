添加方法如下：
方法一：
（1）插设备和不插设备情况下，分别执行lsusb，找到该设备的对应项。aaaa:bbbb 分别是vendorId和productId
（2）在/etc/udev/rules.d/70-android.rules文件中添加项：
    SUBSYSTEM=="usb", ATTRS{idVendor}=="aaaa", ATTRS{idProduct}=="bbbb",MODE="0666"   注意aaaa和bbbb的替换，保存文件
（3）sudo chmod a+rx /etc/udev/rules.d/70-android.rules    增加文件权限，可以先查看，all已有了rx权限时，可以不再执行添加
（4）sudo /etc/init.d/udev restart
（5）sudo ./adb kill-server
        
方法二：
        
（1）在～/.android/adb_usb.ini文件内添加一行0xaaaa   aaaa还是方法一中找到的vendorId
（2）重启adb server即可:    sudo ./adb kill-server
