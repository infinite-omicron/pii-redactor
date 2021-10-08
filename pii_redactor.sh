#!/bin/bash
set -eu
# variables in use
version="0.0.1"

dir=$2
REDACT="**********"
debug=0
verbose=0


# official version will write to actual .yml

yml=$(find "$dir" -name "cluster.yml") 
sed -e "s/\(address: \)\(.*\)/\1$REDACT/;
s/\(user: \)\(.*\)/\1$REDACT/;
s/\(ssh_key_path: \)\(.*\)/\1$REDACT/;
s/\(ssh_cert_path: \)\(.*\)/\1$REDACT/;
s/\(hostname_override: \)\(.*\)/\1$REDACT/;
s/\(internal_address: \)\(.*\)/\1$REDACT/;
1,/ key:.*/{s// key: $REDACT/};
/-----BEGIN/,/-----END/{/-----BEGIN/n;/-----END/!{s/./        $REDACT/}};" $yml > redacted_clus.yml


usage() {
cat <<EOF
USAGE: 
pii_redactor [command] ... <directory>

COMMANDS:
  <directory>   Redacts PII in directory holding cluster.yml

GLOBAL COMMANDS:
  -h, --help            Show this message
  -d, --debug           Output debug messages
  -v, --verbose         verbose mode
  -ver, --version       Print version
EOF
}

while [ ${#} -gt 0 ]
do
  a=${1}
  shift
  case ${a} in 
    -h|--help) 
      usage
      ;;
    -d|--debug)
      debug=1
      echo "Debug is on"
     ;;   
    -v|--verbose)
      verbose=1
      echo "Verbose is on"
      ;;
    -ver|--version)
      echo "pii_redactor.sh version is ${version}"
      ;;
    redact)
      sedcom
      echo "Redacting File"
      ;;
    $dir)
      ;;
    *) 
     echo "Invalid Input. Try --help or -h"
     ;;
  esac
done
