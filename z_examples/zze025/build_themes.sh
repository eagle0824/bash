#! /bin/bash
#根据自己配置的gradle路径配置, 或者修改下面编译指令用gradlew指令
export GRADLE_HOME=/home/imotor/.sdkman/candidates/gradle/current/bin/gradle
#根据本地SDK配置修改ANDROID_HOMD
export ANDROID_HOME=/work/tools/android-sdk/
export PATH=$PATH:$GRADLE_HOME/bin
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

#theme.zip的名字,自行修改
themes_name="imt_themes_"`date +%Y-%m-%d_%H_%M_%S`

path=$PWD

for name in `ls $path`
do
    file=$path/$name 
    if [ ${file##*.} = zip ] ;then
        rm $file
    fi

done
 
themes_path="$path/current"
if [ -e "$themes_path" ]
then 
    rm "$themes_path" -rf
fi
mkdir -p $themes_path/vendor/overlay
mkdir -p $themes_path/bootlogo

if [ -d $path/bootlogo ]; then
    cp -r $path/bootlogo/*  $themes_path/bootlogo
else
    echo "error not find bootlogo dir"
fi

#compile overlay apps
app_dir=$path/packages/apps
for name in `ls $app_dir`
do
    app_path=$app_dir/$name
    if [ -d $app_path  ]; then
        appname=`basename $app_path`
        echo $app_path 
        pushd $app_path
        gradle clean
        gradle assembleRelease 2>&1 | tee ${appname}.log
        appname=`grep "LOCAL_MODULE " Android.mk | awk '{print $NF}'`
        cp app/build/outputs/apk/release/app-release.apk $path/current/vendor/overlay/${appname}.apk
        popd
    fi 
done

zip -r ${themes_name}.zip current theme_apps_verification
