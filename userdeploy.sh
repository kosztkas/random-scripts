#!/bin/bash

#Setup variables
groupname=cicakok
groupid=666
uid_base=1100
users=(
    aladar
    bela
    cica
)

groupadd -g ${groupid} "${groupname}"

echo "${groupname} created with id ${groupid}"

cat << EOF > /etc/sudoers.d/${groupname}-users
## Allows people in group ${groupname} to run all commands without a password
%${groupname} ALL=(ALL:ALL) NOPASSWD: ALL
EOF

for user in "${users[@]}"; do

    useradd -m --uid $((++uid_base)) -g ${groupid} "${user}"

    echo "${uid_base}:${groupid} ${user} is created"

    mkdir -p /home/"${user}/".ssh
    touch /home/"${user}"/.ssh/authorized_keys

    chown -R ${uid_base}:${groupid} /home/"${user}"/.ssh
done
