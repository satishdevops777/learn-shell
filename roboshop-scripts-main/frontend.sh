source common.sh
component=frontend

echo -e "${color} Install nginx ${nocolor}"
yum install nginx -y &>>${log_file}
stat_check $?

echo -e "${color} Removing default content ${nocolor}"
rm -rf /usr/share/nginx/html/* &>>${log_file}
stat_check $?

echo -e "${color} Download Application Content ${nocolor}"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}
cd /usr/share/nginx/html &>>${log_file}
unzip -o /tmp/frontend.zip &>>${log_file}
stat_check $?

echo -e "${color} copy ${component} configuration file ${nocolor}"
cp /home/centos/roboshop-scripts/frontend.service /etc/nginx/default.d/roboshop.conf &>>${log_file}
stat_check $?

echo -e "${color} Starting ${component} service ${nocolor}"
systemctl enable nginx &>>${log_file}
systemctl restart nginx &>>${log_file}
stat_check $?
