#!/usr/bin/env bash

LIST_TYPE="$1"
INPUT_FILE="$2"
OUTPUT_FILE="$3"
LIST_NAME="$4"


if [ -z "${LIST_NAME}" ]
then
	echo "Missing list name" >&2
	exit 1
fi

if [ ! -f "${INPUT_FILE}" ]
then
	echo "Missing input file => [ ${INPUT_FILE} ]" >&2
	exit 2
fi

TMP_FILE=$(mktemp)

case "${LIST_TYPE}" in
	v4|ipv4)
	echo "/ip/firewall/address-list" >> "${TMP_FILE}"
	;;
	v6|ipv6)
	echo "/ipv6/firewall/address-list" >> "${TMP_FILE}"

	;;
	*)
		echo "Not a valid list type" >&2
		exit
	;;
esac

while read cidr; do
	echo "add list=\"${LIST_NAME}\" address=${cidr}" >> "${TMP_FILE}"
done <"${INPUT_FILE}"

if [ -f "${OUTPUT_FILE}" ]
then 
        diff "${TMP_FILE}" "${OUTPUT_FILE}" >/dev/null 2>&1
        RES="$?"

        if [ "${RES}" -gt 0 ]
        then
                cp -vf "${TMP_FILE}" "${OUTPUT_FILE}"
        else
                echo "The list file was not changed!" >&2
        fi
else
        cp -vf "${TMP_FILE}" "${OUTPUT_FILE}"
fi

rm -vf "${TMP_FILE}"
