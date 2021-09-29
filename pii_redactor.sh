#!/bin/bash

# variables in use
version="0.2"
yml="cluster.yml"
REDACT="****************"

#WIP
debug=0
verbose=0


case $1 in 
  -h|--help) 
    cat <<EOF
USAGE: 
$0 [command]

COMMANDS:
  -h, --help            Show this message and quit
  -d, --debug           Output debug messages
  -v, --verbose         verbose mode
  -ver, --version       Print version and exit
EOF
    ;;
  -d|--debug)
    debug=1
    ;;
  -v|--verbose)
    verbose=1
    ;;
  -ver|--version)
    echo "PII_Redaction.sh version is ${version}"
    ;;
esac

sed -e " /#.*/ d;
s/\(address: \)\(.*\)/\1$REDACT/;
s/\(user: \)\(.*\)/\1$REDACT/;
s/\(ssh_key_path: \)\(.*\)/\1$REDACT/;
s/\(ssh_cert_path: \)\(.*\)/\1$REDACT/;
s/\(hostname_override: \)\(.*\)/\1$REDACT/;
s/\(internal_address: \)\(.*\)/\1$REDACT/;
s/\(key: \)\(.*\)/\1$REDACT/;
/-----BEGIN/,/-----END/{/-----BEGIN/n;/-----END/!{s/./        $REDACT/}};" $yml > redacted_clus.yml
