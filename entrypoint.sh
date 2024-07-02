#!/bin/bash

IFS=' ' read -r -a args <<< "${SYFT_CMD_ARGS}"

echo "syft-bitbucket-pipe: running the following command"
echo "syft ${SYFT_CMD_ARGS}"

syft "${args[@]}"
