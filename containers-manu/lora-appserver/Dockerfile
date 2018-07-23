FROM loraserver/lora-app-server:1
MAINTAINER Asgard Team "manuel.sanchezlopez@altran.com"

COPY ./configuration/lora-app-server /etc/lora-app-server

WORKDIR /root/

EXPOSE 8080

ENTRYPOINT ["./lora-app-server"]
