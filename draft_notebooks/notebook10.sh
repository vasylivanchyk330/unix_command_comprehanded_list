#!/bin/bash

# This script demonstrates the use of functions.

log() {
  # This function sends a message to syslog and to standard output if VERBOSE is true.

  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
  logger -t luser-demo10.sh "${MESSAGE}"
}
# logger -- the script file that logs with the schema: timestamp, user_name, tag:log
# logger -t -- allows to set a tag

# good practice is to put all the functions in the top of a script file right after constant vars

backup_file() {
  # This function creates a backup of a file.  Returns non-zero status on error.

  local FILE="${1}"

  # Make sure the file exists.
  if [[ -f "${FILE}" ]]
  then
    local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
    log "Backing up ${FILE} to ${BACKUP_FILE}."

    # The exit status of the function will be the exit status of the cp command.
    cp -p ${FILE} ${BACKUP_FILE}
    # -p stands for preserve mode, ownership and timestamp

  else
    # The file does not exist, so return a non-zero exit status.
    return 1
  fi
}

readonly VERBOSE='true'
log 'Hello!'
log 'This is fun!'

backup_file /etc/passwd

# Make a decision based on the exit status of the function.
# Note this is for demonstration purposes.  You could have
# put this functionality inside of the backup_file function.
if [[ "${?}" -eq '0' ]]
then
  log 'File backup succeeded!'
else
  log 'File backup failed!'
  exit 1
fi

