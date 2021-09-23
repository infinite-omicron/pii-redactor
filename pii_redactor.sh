#!/bin/bash  

yml="cluster.yml"
REDACT="******"

sed -e " s/\(address: \)\(.*\)/\1$REDACT/;
s/\(user: \)\(.*\)/\1$REDACT/;
s/\(ssh_key_path: \)\(.*\)/\1$REDACT/;
s/\(ssh_key: \)\(.*\)/\1$REDACT/;
s/\(ssh_cert_path: \)\(.*\)/\1$REDACT/;
s/\(ssh_cert: \)\(.*\)/\1$REDACT/;
s/\(hostname_override: \)\(.*\)/\1$REDACT/;
s/\(internal_address: \)\(.*\)/\1$REDACT/;
s/\(key: \)\(.*\)/\1$REDACT/" $yml > redacted_clus.yml
