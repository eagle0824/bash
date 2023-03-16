预置第三方apk需要写Android.mk
并解压对应的库到app/lib目录下面
需要默认给予app dangeous权限

此脚本的功能就是根据xxxx.apk, 自动生成打包编译的文件目录xxxx


使用注意事项
1 xxxx.apk 名字中不要有中文 

2 xxx.apk 预置在系统/system/app中 
生成的xxxx目录下面的Android.mk 固定为system/app 如果不一致, 执行之后需要手动修改 

3 预置仓库为vendor/3rd-party. 
生成的xxxx目录下面xxxx.mk, 打包so以及默认权限的路径是以vendor/3rd-party开始的, 如果不一致执行之后需要手动修改

4 添加新的xxxx.apk 注意要在vendor/3rd-party仓库的3rd-party.mk引用生成的xxxx.mk
$(call inherit-product-if-exists, vendor/3rd-party/xxxx/xxxx.mk)

5 每个三方目录仅一个apk, 如果有多个, 需要自行合并处理





使用方式
cd app_perset_tool
. run.sh path 
(path是apk放置的目录名字)
工具会遍历path一级目录里面的apk, 生成需要提交的以app名字命名的目录


更新或预置第三方app

1 可以将需要更新的apk直接放置到vendor/3rd-party目录下面
2 执行
. run.sh 3rd-party目录
3 执行之后
rm -rf *.apk
4 如果新增加的app, 参考使用注意事项中的4
5 核对差异, 
6 push到系统验证
7 确认无误可以提交
