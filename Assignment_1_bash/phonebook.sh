# !/bin/bash

#set -x

#make this database_file your script file and append the data to it .
database_file="/home/abdoo/.phonebookDB.txt"

if [ $# -ne 1 ]
then
echo "Wrong Number of arguments "
exit 1
fi

if [ ! -e "/home/abdoo/.phonebookDB.txt" ]
then
echo "Database File doesn't exist, a new one will be created"
touch $database_file
fi


function insert {
is_num='^[0-9]+$'

#Take use input
read -p "Please Enter Contact Name : " contactName
read -p "Please Enter The Phone Number : " phoneNumber

#validate that the phone number is digits
if ! [[ $phoneNumber =~ $is_num ]];then
 echo "ERROR: Phone must be a number " >&2;exit 1
else
 echo "$contactName: $phoneNumber" >> $database_file
fi

#should validate that this name doesn't exist already
}


function viewAll {
cat $database_file
}


function search {
read -p "Enter Contact Name : " search_name
cat $database_file | grep $search_name || echo "NOT FOUND"
}


function deleteAll {
read -p "Are you sure ? y/n " choice
if [ $choice = "y" -o $choice = "Y" ]
then
> $database_file
else
 echo "Don't worry your database is fine "
 exit 0
fi
}


function delete {

read -p "Enter Contact Name To Be Deleted : " contact_name
cat $database_file | grep $contact_name > /dev/null

if [ $? -eq 0 ]
then
	sed -i "/^$contact_name:/"d $database_file
	echo "Contact deleted successfully "
else
	echo "Contact doesn't exist already"
fi
}


#Switching on user args
case $1 in
-i) insert    ;;
-v) viewAll   ;;
-s) search    ;;
-e) deleteAll ;;
-d) delete    ;;
* ) echo "Wrong Argument "
    exit 1    ;;
esac
