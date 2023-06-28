#!/usr/bin/env bash

set -eu -o pipefail

log() {
  local prog
  prog=$(basename "$0")
  echo "$(date '+[%Y-%m-%d %H:%M:%S]') ${prog}: INFO: $@"
}

error() {
  local prog
  prog=$(basename "$0")
  echo "$(date '+[%Y-%m-%d %H:%M:%S]') ${prog}: ERROR: $@" >&2
  exit 1
}

run() {
  local names
  set +e
  names=$(docker ps --format "{{.Names}} {{.Image}}" | grep jvmplayground)
  set -e
  if [[ "${names}" =~ .*jvmplayground.* ]]; then
    docker exec -it "${names% *}" $@
  else
    docker run --privileged -it \
        --memory 2g \
        -v "$(pwd)":/root/proj/ \
        -p 8888:8888 \
        -p 9898:9898 \
        -p 8080:8080 \
        --env-file .env \
        jvmplayground:latest $@
  fi
}

gcgc() {
  cd /root/GCGC/src/notebooks/
  jupyter notebook --allow-root --ip 0.0.0.0
  cd -
}

main() {
  if [[ $# -eq 0 ]]; then
    error "provide params"
  fi
  java_opts=""
  while [[ $# -gt 0 ]]; do
    case $1 in
      run)
        shift
        run "$@"
        break
        ;;
      gcgc)
        shift
        gcgc
        break
        ;;
      --java-opts)
        shift
        java_opts="$1"
        shift
        ;;
      *)
        error "unknown option"
        ;;
    esac
  done
}

main "$@"
