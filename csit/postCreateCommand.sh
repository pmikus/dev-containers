#!/usr/bin/env bash

for key in $(ls /root/.ssh/id_*[!pub]); do
    echo "    IdentityFile ${key}" >> /etc/ssh/ssh_config
done
