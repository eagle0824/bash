#!/bin/bash
file_path=/dir1/dir2/dir3/my.file.txt
echo $file_path
echo '${file_path:5:5} :'${file_path:5:5}
echo '${file_path#*/} :'${file_path#*/}
echo '${file_path##*/} :'${file_path##*/}
echo '${file_path%*/} :'${file_path%/*}
echo '${file_path%%/*} :'${file_path%%/*}
echo '${#file_path} :'${#file_path}
