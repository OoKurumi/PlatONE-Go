#!/bin/sh

pids=`ps -ef | grep platone | grep -v grep | awk '{print $2}'`

if [ $pids"x" != "x" ]; then
    echo "An old platone process[$pids] is runing, please stop it first."
    exit
fi

#mkdir -p ../logs

datadir="--datadir ../data"
nodekey="--nodekey ../data/node.prikey"
rpc="--rpcaddr 0.0.0.0 --rpcport 6789 --rpcapi db,eth,net,web3,admin,personal --rpc"
#logs="--verbosity 4 --wasmlog ../logs/wasm.log >>../logs/platone.log" #redirection not work in scrypt, why?
logs="--verbosity 4 --wasmlog ./wasm.log"

nohup ./platone --identity platone --nodiscover --rpccorsdomain "*" $datadir $nodekey $rpc $logs 2>&1 &

sleep 1

pids=`ps -ef | grep platone | grep -v grep | awk '{print $2}'`

if [ $pids"x" != "x" ]; then
    echo "Start platone succ. pid[$pids]"
fi
