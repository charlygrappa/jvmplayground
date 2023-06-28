#!/usr/bin/env bash

echo "Starting GCGC"
cd /root/GCGC/src/notebooks/
jupyter notebook --allow-root --ip 0.0.0.0
