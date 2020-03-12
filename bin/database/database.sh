#!/usr/bin/env bash

LOCAL_HOST=127.0.0.1

check_input_param() {
    arg0=$1
    message=$2

    if [ -z "$arg0" ]
    then
        echo "$message"
        exit
    fi
}

export_data() {
    printf "DB Host: "
    read host
    check_input_param "$host" "Invalid database host!"
    if [ $host = "localhost" ]
    then
        host=$LOCAL_HOST
    fi

    printf "DB User: "
    read user
    check_input_param "$user" "Invalid database user!"

    printf "DB Password: "
    read -s password
    echo ""
    check_input_param "$password" "Invalid database password!"

    printf "DB port: "
    read port
    check_input_param "$port" "Invalid database port!"

    echo "DB schema(s): (input 'schema1 schema2' when you want to export multiple schema)"
    read schemas
    check_input_param "$schemas" "Invalid database schemas!"

    printf "Output file path: "
    read -e path
    check_input_param "$path" "Invalid database path!"

    printf "Do you want to export with data (Y/N): "
    read isContainData

    if [ $isContainData = "Y" ]
    then
        sudo mysqldump --databases $schemas --result-file=$path --user=$user --password=$password --host=$host --port=$port --routines --triggers
        exit
    elif [ $isContainData = "N" ]
    then
        sudo mysqldump --databases $schemas --result-file=$path --user=$user --password=$password --host=$host --port=$port --routines --triggers --no-data
        exit
    fi
    echo "Invalid option!"
}

import_data() {
    printf "DB User: "
    read user
    check_input_param "$user" "Invalid database user!"

    printf "DB Password: "
    read -s password
    echo ""
    check_input_param "$password" "Invalid database password!"

    printf "DB port: "
    read port
    check_input_param "$port" "Invalid database port!"

    printf "SQL file path: "
    read -e path
    check_input_param "$path" "Invalid sql file path!"

    sudo mysql --user=$user --password=$password --host=$LOCAL_HOST --port=$port < $path
}

echo "Please Select options:"
echo "   - 0: Exit"
echo "   - 1: Export database to file."
echo "   - 2: Import database from file to local database."

while :
do
   read KEY
   case $KEY in
      0)
         echo "Bye!"
         exit
         ;;
      1)
         echo "Export database to file."
         export_data
         exit
         ;;
      2)
         echo "Import database from file to local database."
         import_data
         exit
         ;;
      *)
         echo "Sorry!"
         exit
         ;;
   esac
done
