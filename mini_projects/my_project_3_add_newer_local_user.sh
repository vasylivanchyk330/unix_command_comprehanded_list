#!/bin/bash

# This script creates a new user on the local system.
# You must supply a username as an argument to the script.
# Optionally, you can also provide a comment for the account as an argument.
# A password will be automatically generated for the account.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then
  echo "please, to proceed, login as a root user" >&2
  exit 1
fi

# If the user doesn't supply at least one argument, then give them help.
if [[ "${#}" -eq 0 ]]
then
  echo "please provide any parameter next time" >&2
  exit 1
fi

# The first parameter is the user name. shifting, create a new usesr
USERNAME=${1}
shift
COMMENT=${*}
useradd -c "${COMMENT}" -m ${USER_NAME}

# check if previous command was good
if [[ "${?}" -eq 1 ]]
then
  echo "user creation failed. please try again" >&2
  exit 1
fi

# password assigning
PASSWORD=$(date +%s%N | sha256sum | head -c48)
echo "${USER_NAME}: ${PASSWORD}"

# check if previous command was good
if [[ "${?}" -eq 1 ]]
then
  echo "password assigning failed. please try again" >&2
  exit 1
fi

# recap the information to the user
echo "just created user name: ${USER_NAME}"
echo "a password for the just created user name: ${PASSWORD}"
echo "the hostname: ${HOSTNAME}"
exit 0
