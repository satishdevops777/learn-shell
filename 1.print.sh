# To print a message there are couple of commands, But echo is widely used one

echo Hello World

# while printing some times to grab the attention of user we might need to print in some color
# syntax : echo -e "\e[COLmMESSAGE\e[0m"
# -e - enable colors
# \e[COLm - To enable certain color
# \e[0m - TO disable color which is enabled
# COL stands for color and possible colors are RED(31), GREEN(32), YELLOW(33), BLUE(34), MAGENTA(35), CYAN(36)

echo -e "\e[31mHello in Red Color\e[0m"
echo -e "\e[32mHello in Green Color\e[0m"
echo -e "\e[33mHello in Yellow Color\e[0m"
echo -e "\e[34mHello in Blue Color\e[0m"
echo -e "\e[35mHello in Magenta Color\e[0m"
echo -e "\e[36mHello in Cyan Color\e[0m"



#!/bin/bash

echo "Enter your name:"
read name
echo "Hello $name"


#!/bin/bash

read -p "Enter your name: " name
echo "Hello $name"

# read -t 5 -p "Enter value in 5 seconds: " val
# read -n 1 -p "Continue? (y/n): " choice
