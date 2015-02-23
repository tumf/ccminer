#!/bin/bash
export PATH=/usr/local/cuda/bin:$PATH
ccminer -o http://${WALLETS_PORT_9000_TCP_ADDR}:${WALLETS_PORT_9000_TCP_PORT} $*
