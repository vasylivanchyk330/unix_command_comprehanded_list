#!/bin/bash/

# This script creates a new user on the local system.
# You will be prompted to enter the username (login), the person name, and a password.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then
   echo 'Please run with sudo or as root.'
   exit 1
fi

# Get the username, name, and password.
read -p 'enter you username: ' USER_NAME

read -p 'enter you name: ' COMMENT

read -p 'enter you password: ' PASSWORD


# Create the account and set the password
useradd -c "${COMMENT}" -m ${USER_NAME}
echo "${USER_NAME}:${PASSWORD}" | chpasswd

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then
    echo "the request to create a user FAILED"
    exit 1
else
    echo "the request to create a user SUCCEEDED"
fi

# print out the information
echo "you username is ${USER_NAME}"
echo "you password is ${PASSWORD}"
echo "your hostname is ${HOSTNAME}"
exit 0