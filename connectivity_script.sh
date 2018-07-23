#!/bin/bash
while true; do
if kubectl get nodes -s http://10.10.10.51:8080 | grep 'minion-1   Ready'; then
   if [ -n "$(grep '10.10.10.52 lora-server' /etc/hosts)" ]
      then
         echo "lora-server entry is set to minion-1"
         sudo sed -i".bak" "/10.10.10.53 lora-server/d" /etc/hosts
      else
         echo "Adding lora-server entry to minion-1";
         sudo -- sh -c -e "echo '10.10.10.52 lora-server' >> /etc/hosts";
         sudo sed -i".bak" "/10.10.10.53 lora-server/d" /etc/hosts
   fi
elif kubectl get nodes -s http://10.10.10.51:8080 | grep 'minion-2   Ready'; then
   if [ -n "$(grep '10.10.10.53 lora-server' /etc/hosts)" ]
      then
         echo "lora-server entry is set to minion-2"
         sudo sed -i".bak" "/10.10.10.52 lora-server/d" /etc/hosts
      else
         echo "Adding lora-server entry to minion-1";
         sudo -- sh -c -e "echo '10.10.10.53 lora-server' >> /etc/hosts";
         sudo sed -i".bak" "/10.10.10.52 lora-server/d" /etc/hosts
   fi
fi;
sleep 1m;
done
