# JVM Performance Playground

Throughly adapted from [Sergey Tselovalnikov post on the JVM's memory](https://serce.me/posts/01-02-2023-jvm-field-guide-memory)

This containers updates Sergey's version with the current launch mode of async-profiler (profile.sh has been removed from the current version) and adds several linux tools to monitor process performance such as

* iostat
* vmstat
* sar
* strace

## Environment & Settings

The root directory has a .env file to feed environment info to the container, by default it has some JAVA_OPTS to enable GC collection. But anything can be added with the regular format for a dotenv file

```
VARIABLE=VALUE
``` 

The container will start by default with 2GB of ram and will expose the following ports

* 8888 
* 8889 
* 8080 -> In case you run a webabpp an want to drive traffic to it

## Launching programs from inside the container

the launch_jar.sh script runs the specified jar-file all the following parameters will be passed to async-profiler. The script will sleep for one second so as to give the JVM enough time to create the attach socket.

## Collecting GC Info

This container adds the excellent GCGC tool, and by default it collects data about the GC, such as safepoints and timing, so in order to analyze GC data you need to run from a separate terminal the following command

./run.sh run gcgc.sh 


