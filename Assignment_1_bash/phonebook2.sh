# !/bin/bash

#set -x

#make this database_file your script file and append the data to it .
database_file="phonebook2.sh"

if [ $# -ne 1 ]
then
echo "Wrong Number of arguments "
exit 1
fi


function insert {
is_num='^[0-9]+$'

#Take use input
read -p "Please Enter Contact Name : " contactName
read -p "Please Enter The Phone Number : " phoneNumber

#should validate that this name doesn't exist already
awk "/^$contactName:\s[0-9]+/ {exit 1} " $database_file 
if [ $? -eq 1 ]
then
echo "ERROR:Name Already Exists !!"
exit 1
fi


#validate that the phone number is digits
if ! [[ $phoneNumber =~ $is_num ]];then
 echo "ERROR: Phone must be a number " >&2;exit 1
else
 echo "$contactName: $phoneNumber" >> $database_file
fi

}


function viewAll {
awk '/^[a-z]+:\s[0-9]+/ {print; $result=1}' $database_file | grep . || echo "There are no Contacts to show !"
}

function search {
read -p "Enter Contact Name : " search_name
awk "/^$search_name:\s[0-9]+/ {print; } " $database_file | grep . || echo "Contact is Not Found !"
}


function deleteAll {
read -p "Are you sure ? y/n " choice
if [ $choice = "y" -o $choice = "Y" ]
then
gawk -i inplace '!/^[a-z]+:\s[0-9]+/' $database_file && echo "you no longer have any contacts "
else
 echo "Don't worry your database is fine ^_^"
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
exit 0
-----
abdoo: 123456
