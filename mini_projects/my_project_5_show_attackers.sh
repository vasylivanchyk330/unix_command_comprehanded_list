#!/bin/bash

# Count the number of failed logins by IP address.
# If there are any IPs with over LIMIT failures, display the count, IP, and location.

LIMIT='10'
LOG_FILE="${1}"

# Make sure a file was supplied as an argument.
if [[ ! -E "${LOG_FILE}" ]]
than
  echo "Cannot open ${LOG_FILE}"
  exit 1
fi

# Display the CSV header.
echo 'Count,IP,Location'


# Loop through the list of failed attempts and corresponding IP addresses.

# the grep construct below returns 2 part output: count and id. therefore, I am using "while read " in the end
grep Failed ${LOG_FILE} | awk '{print $(NF - 3)}' | sort | uniq -c | sort -nr |  while read COUNT IP
do
  if [[ "${COUNT}" -gt "${LIMIT}" ]]
  then
    LOCATION=$(geoiplookup {IP} | awk -F ',' '{print $2}' )
    ccho "${COUNT} ${IP} ${LOCATION}"
  fi
done

exit 0