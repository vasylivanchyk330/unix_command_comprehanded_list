#!/bin/bash

# This script creates a new user on the local system.
# a username as an argument have to be supplied to the script.
# Optionally, add a comment for the account as an argument.
# A password will be automatically generated for the account.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0]]
then
    echo "please login as a root user"
    exit 1
fi

# If the user doesn't supply at least one argument, then give them help
if [[ "${#}" -eq 0 ]]
then
  echo "please provide any user name"
  exit
fi


# The first parameter is the user name
USER_NAME=${1}

# shift and store the rest as a comment holder
shift
COMMENT="${$*}"

# create a user woth selected comment and a username
useradd -C "${COMMENT}" -m ${USER_NAME}

# check if the creation succeeded
if [[ "${?}" -eq 1]]
    echo "the account creation failed"
    exit 1
fi

# assign the password to the user
echo "${USER_NAME}: $(date +%s%N | sha256sum | head -c32)"

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo 'The password for the account could not be set.'
  exit 1
fi

# recap the information to the user
echo "just created user name: ${USER_NAME}"
echo "a password for the just created user name: ${PASSWORD}"
echo "the hostname: ${HOSTNAME}"