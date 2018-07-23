FROM loraserver/lora-gateway-bridge:2
MAINTAINER Asgard Team "manuel.sanchezlopez@altran.com"

COPY ./configuration/lora-gateway-bridge /etc/lora-gateway-bridge

WORKDIR /root/

EXPOSE 1700

ENTRYPOINT ["./lora-gateway-bridge"]
