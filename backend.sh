echo -e "\e[32mDisable NodeJS Default Version\e[0m"
dnf module disable nodejs -y &>>/tmp/expense.log

echo -e "\e[32mEnable NodeJS 18 Version\e[0m"
dnf module enable nodejs:18 -y &>>/tmp/expense.log

echo -e "\e[32mInstall NodeJS\e[0m"
dnf install nodejs -y &>>/tmp/expe

echo -e "\e[32mConfigure Backend Service\e[0m"
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log

echo -e "\e[32mAdding Application User\e[0m\e[0m"
useradd expense &>>/tmp/expense.log

echo -e "\e[32mRemove existing App content\e[0m"
rm -rf /app &>>/tmp/expense.log

echo -e "\e[32mCreate Application Directory\e[0m"
mkdir /app &>>/tmp/expense.log

echo -e "\e[32mDownloading Application Content\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>/tmp/expense.log
cd /app

echo -e "\e[32mExtracting Application Content\e[0m"
unzip /tmp/backend.zip &>>/tmp/expense.log

echo -e "\e[32mDownloading Application Dependencies\e[0m"
npm install &>>/tmp/expense.log


echo -e "\e[32mReloading SystemD and Starting Backend Service\e[0m"
systemctl daemon-reload &>>/tmp/expense.log

systemctl enable backend &>>/tmp/expense.log
systemctl restart backend &>>/tmp/expense.log

echo -e "\e[32mInstall MySQL Client\e[0m"
dnf install mysql -y &>>/tmp/expense.log

echo -e "\e[32mLoad Schema\e[0m"
mysql -h 172.31.41.227 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>/tmp/expense.log





