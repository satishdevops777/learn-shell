color="\e[36m"
nocolor="\e[0m"
log_file=/tmp/roboshop.log
app_path=/app
user_id=$(id -u)
if [ $user_id -ne 0 ]; then
  echo Script should be running with sudo
  exit 1
fi

stat_check() {
  if [ $1 -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
    exit 1
  fi
}

presetup_app () {
  echo -e "${color} Add roboshop User ${nocolor}"
  id roboshop &>>$log_file
  if [ $? -eq 1 ]; then
    useradd roboshop  &>>$log_file
  fi
  stat_check $?

  echo -e "${color} Create app directory ${nocolor}"
  rm -rf /app   &>>$log_file
  mkdir /app
  stat_check $?

  echo -e "${color} Download ${component} application file ${nocolor}"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>log_file
  stat_check $?
  
  echo -e "${color} Extract Application Content${nocolor}"
  cd ${app_path}
  unzip /tmp/${component}.zip  &>>$log_file
  stat_check $?
}

nodejs () {
  echo -e "${color} Configuring NodeJS Repos ${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>$log_file
  stat_check $?

  echo -e "${color} Install NodeJS${nocolor}"
  yum install nodejs -y  &>>$log_file
  stat_check $?

  presetup_app

  echo -e "${color} Install nodejs dependencies ${nocolor}"
  npm install &>>log_file
  stat_check $?
  
  systemd_service
}

systemd_service () {
  echo -e "${color} Setup SystemD Service  ${nocolor}"
  cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service  &>>$log_file
  sed -i -e "s/roboshop_app_password/$roboshop_app_password/"  /etc/systemd/system/${component}.service
  stat_check $?

  echo -e "${color} Start ${component} Service ${nocolor}"
  systemctl daemon-reload  &>>$log_file
  systemctl enable ${component}  &>>$log_file
  systemctl restart ${component}  &>>$log_file
  stat_check $?
}

maven() {
  echo -e "${color} Install Maven ${nocolor}"
  yum install maven -y  &>>$log_file
  stat_check $?

  presetup_app

  echo -e "${color} Download Maven Dependencies ${nocolor}"
  mvn clean package  &>>$log_file
  sudo mv target/${component}-1.0.jar ${component}.jar  &>>$log_file
  stat_check $?
  
  mysql_schema
  systemd_service
}

mongo_schema_setup() {
  echo -e "${color} Copy MongoDB Repo file ${nocolor}"
  cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>>$log_file
  stat_check $?

  echo -e "${color} Install MongoDB Client ${nocolor}"
  yum install mongodb-org-shell -y  &>>$log_file
  stat_check $?

  echo -e "${color} Load Schema ${nocolor}"
  mongo --host mongodb-dev.devopsprojects.store <${app_path}/schema/${component}.js  &>>$log_file
  stat_check $?
}

mysql_schema () {
  echo -e "${color} Install mysql ${nocolor}"
  sudo yum  install mysql -y &>>$log_file

  echo -e "${color} Load schema ${nocolor}"
  mysql -h mysql-dev.devopsprojects.store -uroot -p${mysql_root_password} < ${app_path}/schema/${component}.sql &>>$log_file

  echo -e "${color} Restart ${component} service ${nocolor}"
  systemctl restart shipping &>>$log_file
}

python () {
  echo -e "${color} Install python ${nocolor}"
  yum install python36 gcc python3-devel -y &>>$log_file
  stat_check $?
  
  presetup_app

  echo -e "${color} Install python dependencies ${nocolor}"
  cd app_path
  pip3.6 install -r requirements.txt &>>$log_file
  stat_check $?
  
  systemd_service
}

go_lang() {
  echo -e "${color} Install golang ${nocolor}"
  sudo yum install install golang -y &>>$log_file

  presetup_app

  echo -e "${color} go config commands ${nocolor}"
  go mod init dispatch &>>$log_file
  go get &>>$log_file
  go build &>>$log_file

  systemd_service
}
