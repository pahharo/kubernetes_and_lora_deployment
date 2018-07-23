#!/bin/bash
ssh-keygen -f "/home/jvalderrama/.ssh/known_hosts" -R 10.10.10.51
ssh-copy-id -o StrictHostKeyChecking=no root@10.10.10.51
ssh-keygen -f "/home/jvalderrama/.ssh/known_hosts" -R 10.10.10.52
ssh-copy-id -o StrictHostKeyChecking=no root@10.10.10.52
ssh-keygen -f "/home/jvalderrama/.ssh/known_hosts" -R 10.10.10.53
ssh-copy-id -o StrictHostKeyChecking=no root@10.10.10.53

#ssh-keygen -f "/home/jvalderrama/.ssh/known_hosts" -R master
#ssh-copy-id -o StrictHostKeyChecking=no root@master
#ssh-keygen -f "/home/jvalderrama/.ssh/known_hosts" -R minion-1
#ssh-copy-id -o StrictHostKeyChecking=no root@minion-1
#ssh-keygen -f "/home/jvalderrama/.ssh/known_hosts" -R minion-2
#ssh-copy-id -o StrictHostKeyChecking=no root@minion-2
