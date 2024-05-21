#!/usr/bin/env bash
echo "Effective Javaopts are $JAVA_OPTS"
echo "jemalloc settings is installed in $LD_PRELOAD"
echo "run this from inside the container"
MALLOC_CONF=prof:true,lg_prof_interval:30,lg_prof_sample:17,prof_prefix:jeprof.out,prof_leak:true,prof_final:true java $JAVA_OPTS -jar $1 
