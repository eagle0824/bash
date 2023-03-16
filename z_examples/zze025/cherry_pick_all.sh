# /bin/bash
# master branch commit first, got commit id
# then used this sh, param is commit id
#echo $1

conmmit=$1

if [ -z $commit ] ; then
    echo  "commit id is null, return"
    #return;
fi

var=`cat .git/config | grep branch | awk '{print $2}'`

for data in ${var[*]};
do
    len=${#data}-3
    branch=${data:1:$len}
    if [ $branch != master ] ; then
        echo $branch
        git co $branch && git pull
        git cherry-pick $commit
        git push origin $branch
    fi
done

git co master
git branch -v
