#-*-UTF-8-*-  
from com.android.monkeyrunner import MonkeyRunner as mr  
from com.android.monkeyrunner import MonkeyDevice as md  
from com.android.monkeyrunner import MonkeyImage as mi  
#连接设备  
device=mr.waitForConnection(2,'192.168.56.101:5555')  
#device.installPackage('D:\\baiduliulanqi_186.apk')  
#启动APP  
#device.startActivity('cmp=com.baidu.browser.apps/com.baidu.browser.framework.BdBrowserActivity')  
mr.sleep(3)  
#点击搜索框  
device.touch(100,100,'DOWN_AND_UP')  
mr.sleep(1)  
#输入查询词  
device.type('test')  
mr.sleep(1)  
#点击回车键  
device.press('KEYCODE_ENTER','DOWN_AND_UP')  
mr.sleep(2)  
#截图  
result=device.takeSnapshot()  
#保存到文件  
result.writeToFile('./test.png','png')  
#清除搜索框  
device.touch(100,100,'DOWN_AND_UP')  
mr.sleep(1)  
device.press('KEYCODE_DEL','DOWN_AND_UP')  
mr.sleep(2)
