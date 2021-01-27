#!/bin/bash
  
#Find and kill a proces using the example.pid file
PID_FILE=example.pid
read PID <$PID_FILE
if [-d "/proc/2775"];
then
        ps $PID
        kill $PID
        echo "done"
else
        echo "process $PID not found bo"
fi

APP="python3 print.py"
ROOT_DIR=/home/ubuntu/scripting

TODAY=`date '+%Y%m%d'`
output_dir="result_$TODAY"
mkdir $output_dir
for filename in `ls ${ROOT_DIR}/*.py | sort -r`
do
        name=`basename $filename`
        echo $name
        $APP $filename > "${output_dir}/summary_${name}.txt"
        if [$? != 0]
        then
                echo "Error $? in app"
        fi
        break
done

if ["${output_dir}/summary_${name}.txt" -nt current.txt]
then
        cp "${output_dir}/summary_${name}.txt" current.txt
else
        echo "${output_dir}/summary_${name}.txt Not Newer"
fi


