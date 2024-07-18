#!/usr/bin/env bash

DOWNLOADS_ROOT="./tmp"
OUTPUT_FILE="zoom-ipv4.list"

LISTS=$( ls "${DOWNLOADS_ROOT}/"|grep -v "IPv6" )

TMP_FILE=$(mktemp)

while IFS= read -r line; do
	echo "Processing file: ${DOWNLOADS_ROOT}/${line}"
	cat "${DOWNLOADS_ROOT}/${line}" >> "${TMP_FILE}"
done <<< "$LISTS"


cat "${TMP_FILE}" |sort|uniq > "${TMP_FILE}.in"

if [ -f "${OUTPUT_FILE}" ]
then
	diff "${TMP_FILE}.in" "${OUTPUT_FILE}"
	RES="$?"

	if [ "${RES}" -gt 0 ]
	then
		cp -vf "${TMP_FILE}.in" "${OUTPUT_FILE}"
	else
		echo "The list file was not changed!" >&2
	fi
else
	cp -vf "${TMP_FILE}.in" "${OUTPUT_FILE}"
fi


rm -vf "${TMP_FILE}"
rm -vf "${TMP_FILE}.in"
