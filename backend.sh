MYSQL_PASSWORD=$1
component=backend

source common.sh

Head "Disable NodeJS Default Version"
dnf module disable nodejs -y &>>${log_file}
Stat $?

Head "Enable NodeJS 18 Version"
dnf module enable nodejs:18 -y &>>${log_file}
Stat $?

Head "Install NodeJS"
dnf install nodejs -y &>>/tmp/expe
Stat $?

Head "Configure Backend Service"
cp backend.service /etc/systemd/system/backend.service &>>${log_file}
Stat $?

Head "Adding Application User"
id expense &>>${log_file}
if ["$?" -ne 0 ]; then
  useradd expense &>>${log_file}
fi
Stat $?

App_Prereq "/app"



Head "Downloading Application Dependencies"
npm install &>>${log_file}
Stat $?

Head "Reloading SystemD and Starting Backend Service"
systemctl daemon-reload &>>${log_file}
systemctl enable backend &>>${log_file}
systemctl restart backend &>>${log_file}
Stat $?
Head "Install MySQL Client"
dnf install mysql -y &>>${log_file}
Stat $?

Head "Load Schema"
mysql -h 172.31.41.227 -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>${log_file}
Stat $?




