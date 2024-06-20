echo "Disable NodeJS Default Version"
dnf module disable nodejs -y

echo "Enable NodeJS 18 Version"
dnf module enable nodejs:18 -y

echo "Install NodeJS"
dnf install nodejs -y

echo "Configure Backend Service"
cp backend.service /etc/systemd/system/backend.service

echo "Adding Application User"
useradd expense

echo "Remove existing App content"
rm -rf /app

echo "Create Application Directory"
mkdir /app

echo "Download Application Content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app

echo "Extracting Application Content"
unzip /tmp/backend.zip

echo "Downloading Application Dependencies"
npm install


echo "Reloading SystemD and Starting Backend Service"
systemctl daemon-reload

systemctl enable backend
systemctl restart backend

echo "Install MySQL Client"
dnf install mysql -y

echo "Load Schema"
mysql -h 172.31.41.227 -uroot -pExpenseApp@1 < /app/schema/backend.sql





