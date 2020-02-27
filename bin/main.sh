#!/usr/bin/env bash

ROOT_FOLDER=$(dirname "$(readlink -f "$0")")

echo "Please Select options:"
echo "   - 0: Exit"
echo "   - 1: Database."

while :
do
   read KEY
   case $KEY in
      0)
         echo "Bye!"
         exit
         ;;
      1)
         echo "Database Options:"
         bash "$ROOT_FOLDER/database/database.sh"
         exit
         ;;
      *)
         echo "Sorry!"
         exit
         ;;
   esac
done
