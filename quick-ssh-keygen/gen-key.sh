#!/bin/bash

set -euf -o pipefail

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

TEMPDIR=$(mktemp -d)

printf "${GREEN}Generating keys:${NC}\n"
ssh-keygen -N "" -C "" -f ${TEMPDIR}/key

printf "\n${GREEN}Private key:${NC}\n"
cat ${TEMPDIR}/key

printf "\n${GREEN}Public key:${NC}\n"
cat ${TEMPDIR}/key.pub

printf "\n${GREEN}Private key with removed newlines:${NC}\n"
awk '{printf "%s\\n", $0}' ${TEMPDIR}/key

rm -rf $TEMPDIR
printf "\n\n${YELLOW}Removed keys from filesystem successfully${NC}\n"
