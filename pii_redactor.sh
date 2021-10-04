#!/bin/bash
set -eu
# variables in use
version="0.0.4"
yml="cluster.yml"
REDACT="****************"
debug=0
verbose=0

sedcom() { 
sed -e "s/\(address: \)\(.*\)/\1$REDACT/;
s/\(user: \)\(.*\)/\1$REDACT/;
s/\(ssh_key_path: \)\(.*\)/\1$REDACT/;
s/\(ssh_cert_path: \)\(.*\)/\1$REDACT/;
s/\(hostname_override: \)\(.*\)/\1$REDACT/;
s/\(internal_address: \)\(.*\)/\1$REDACT/;
s/\(key: \)\(.*\)/\1$REDACT/;
/-----BEGIN/,/-----END/{/-----BEGIN/n;/-----END/!{s/./        $REDACT/}};" $yml > redacted_clus.yml
}


usage() {
cat <<EOF
USAGE: 
$0 [command]

COMMANDS:
  redact                Redact PII in rke/cluster

GLOBAL COMMANDS:
  -h, --help            Show this message
  -d, --debug           Output debug messages
  -v, --verbose         verbose mode
  -ver, --version       Print version
EOF
}

case ${1} in 
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
    echo "PII_Redaction.sh version is ${version}"
    ;;
  redact)
    sedcom
    ;;
  *) 
   echo "Invalid Input"
   ;;
esac
