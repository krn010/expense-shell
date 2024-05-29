dnf module disable mysql -y

cp mysql.repo /etc/yum.repos.d/mysql.repo

dnf install mysql-community-server -y

systemctl enable mysqld
systemctl start mysqld

dnf install mysql -y

mysql_secure_installation --set-root-pass ExpenseApp@1


