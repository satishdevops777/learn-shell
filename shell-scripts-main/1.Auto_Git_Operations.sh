#!/bin/bash

echo "Enter Branch name"
read BRANCH_NAME
echo $BRANCH_NAME
git checkout -b $BRANCH_NAME
git add .
git commit -m "Automated Commit"
git push origin $BRANCH_NAME

echo "Code pushed to the repository"
