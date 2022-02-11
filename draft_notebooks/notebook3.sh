#!/bin/bash

# Display the UID and username of the user executing this script.
# Display if the user is an actual user.

# Display the UID.
echo "Your UID is ${UID}"

# usually the user id for users created on Linux systems starts from 1000;
# a user with uid 1000 is the first normal user (non-root user) created on the system.

# Only display if the UID does NOT match 1000.
UID_TO_TEST_FOR='1000'
if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
  echo "Your UID does not match ${UID_TO_TEST_FOR}."
  exit 1
fi

# get the username.
USER_NAME=$(id -un)

# Test if the command succeeded.
# ${?} -- The exit status of the last command executed.
if [[ "${?}" -ne 0 ]]
then
  echo 'The id command did not execute successfully.'
  exit 1
fi
echo "Your username is ${USER_NAME}"

# Test with a string test conditional.
USER_NAME_TO_TEST_FOR='vasylivanchyk330'
if [[ "${USER_NAME}" = "${USER_NAME_TO_TEST_FOR}" ]]
then
  echo "Your username matches ${USER_NAME_TO_TEST_FOR}."
fi

# Test for != (not equal) for the string.
if [[ "${USER_NAME}" != "${USER_NAME_TO_TEST_FOR}" ]]
then
  echo "Your username does not match ${USER_NAME_TO_TEST_FOR}."
  exit 1
fi

exit 0
