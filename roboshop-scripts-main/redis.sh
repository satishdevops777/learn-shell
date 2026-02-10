source common.sh
component=redis

echo -e "${color} Install ${component} repos ${nocolor}"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${logfile}
stat_check $?

echo -e " ${color}  Enable $(component) 6 Version  ${nocolor} "
yum module enable ${component}:remi-6.2 -y &>>/tmp/roboshop.log &>>${logfile}
stat_check $?

echo -e "${color} Install ${component}  ${nocolor}"
sudo yum install ${component} -y &>>${logfile}
stat_check $?

echo -e "${color} Modify ${component} configuration file ${nocolor}"
sed -i 's/127.0.0.0/0.0.0.0' /etc/${component}.conf  /etc/${component}/${component}.conf &>>${logfile}
stat_check $?

echo -e "${color} Start  ${component} service ${nocolor}"
systemctl enable ${component} &>>${logfile}
systemctl start ${component} &>>${logfile}
stat_check $?
