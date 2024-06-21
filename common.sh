
log_file=/tmp/expense.log

Head () {
  echo -e "\e[35m$1\e[0m"
}

App_Prereq () {

  DIR=$1
   
  Head "Remove existing App content"
  rm -rf $1 &>>${log_file}
  echo $?

  Head "Create Application Directory"
  mkdir $1 &>>${log_file}
  echo $?

  Head "Downloading Application Content"
  curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
  echo $?

  cd $1

  Head "Extracting Application Content"
  unzip /tmp/${component}.zip &>>${log_file}
  echo $?



}

Stat ()  {

          if [ $1 = 0 ] ; then
            echo SUCCESS
          else
            echo FAILURE
            exit 1
          fi
}