source common.sh
component=mongod

echo -e "${color} copy ${component} repo file ${nocolor}"
cp /home/centos/roboshop-scripts/mongod.repo /etc/yum.repos.d/mongo.repo  &>>${log_file}
stat_check $?

echo -e "${color} install ${component} repo file ${nocolor}"
yum install mongodb-org -y &>>${log_file}
stat_check $?

echo -e "${color}  update ${component} conf file ${nocolor}"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/${component}.conf  &>>${log_file}
stat_check $?

echo -e "${color} starting ${component} service ${nocolor}"
systemctl enable ${component}  &>>${log_file}
systemctl start ${component}  &>>${log_file}
systemctl restart ${component}  &>>${log_file}
