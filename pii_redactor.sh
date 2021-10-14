#!/bin/bash
set -eu

# variables in use
version="0.0.1"
REDACT="**********"
debug=0
verbose=0
dir=$@

if [ -d "$dir" ]; then
yml=$(find "$dir" -name "cluster.yml")
# official version will write to actual .yml
sed -i "s/\(address: \)\(.*\)/\1$REDACT/;
s/\(user: \)\(.*\)/\1$REDACT/;
s/\(ssh_key_path: \)\(.*\)/\1$REDACT/;
s/\(ssh_cert_path: \)\(.*\)/\1$REDACT/;
s/\(hostname_override: \)\(.*\)/\1$REDACT/;
s/\(internal_address: \)\(.*\)/\1$REDACT/;
1,/ key:.*/{s// key: $REDACT/};
/-----BEGIN/,/-----END/{/-----BEGIN/n;/-----END/!{s/./        $REDACT/}};" "$yml"
echo "Success"
else
echo "Could not find file."
fi

usage() {
cat <<EOF
USAGE: 
pii_redactor [command] || <directory that holds cluster.yml>

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
    "$dir")
      ;; 
    *) 
     echo "Invalid Input. Try --help or -h"
     ;;
  esac
done
