#!/bin/bash  

yml="cluster.yml"
REDACT=******

sed -e "s/address:.*/address: $REDACT/;
s/user:.*/user: $REDACT/;
s/ssh_key_path:.*/ssh_key_path: $REDACT/;
s/ssh_key:.*/ssh_key: $REDACT/;
s/ssh_cert_path:.*/ssh_cert_path: $REDACT/;
s/ssh_cert:.*/ssh_cert: $REDACT/;
s/hostname_override:.*/hostname_override: $REDACT/;
s/internal_address:.*/internal_address: $REDACT/;
s/key:.*/key: $REDACT/" $yml > redacted_clus.yml
