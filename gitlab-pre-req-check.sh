#!/bin/bash

#checking and creating dir for gitlab
home_dir=~/
new_dir="dir_for_gitlab"
mkdir -p "$home_dir$new_dir"

if [ $? -eq 0 ]; then
    echo "Directory $new_dir created sucessfully in $home_dir"
else
    echo "Failed to create directory !"
fi

#setting up the dir in profile
line_to_add="export GITLAB_HOME=$home_dir$new_dir"
echo "$line_to_add" >> ~/.bash_profile

if [ $? -eq 0 ]; then
    echo "Gitlab home path added in profile"
    echo " Please run source ~/.bash_profile now for the changes to take effect !"
else
    echo " Adding Gitlab home path added in profile failed !"
fi

source ~/.bash_profile




