#!/bin/bash
echo $0: creating public and private key files

# Create the .ssh directory
mkdir -p ${HOME}/.ssh
chmod 700 ${HOME}/.ssh

# Create the public and private key files from the environment variables.
echo "${SSH_PUBLIC_KEY}" > ${HOME}/.ssh/heroku_ssh_rsa.pub
chmod 644 ${HOME}/.ssh/heroku_ssh_rsa.pub

# Note use of double quotes, required to preserve newlines
echo "${SSH_PRIVATE_KEY}" > ${HOME}/.ssh/heroku_ssh_rsa
chmod 600 ${HOME}/.ssh/heroku_ssh_rsa

echo "${CLIENT_PUBLIC_KEY}" >> ${HOME}/.ssh/ssh_user_ca
chmod 644 ${HOME}/.ssh/ssh_user_ca

pwd
ls -l ${HOME}/.ssh

# Preload the known_hosts file  (see "version 2" below)

# Start the SSH tunnel if not already running
#SSH_CMD="ssh -f -i ${HOME}/.ssh/heroku_ssh_rsa -N -L 3307:${REMOTE_MYSQL_HOST}:3306 ${REMOTE_USER}@${REMOTE_SITE}"

#PID=`pgrep -f "${SSH_CMD}"`
#if [ $PID ] ; then
#    echo $0: tunnel already running on ${PID}
#else
#    echo $0 launching tunnel
#    $SSH_CMD
#fi
