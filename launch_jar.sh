#!/usr/bin/env bash
echo "Effective Javaopts are $JAVA_OPTS"
java $JAVA_OPTS -jar $1 &
shift
lastPID=$!
echo "Attaching to $lastPID"
sleep 1
asprof $@ $lastPID