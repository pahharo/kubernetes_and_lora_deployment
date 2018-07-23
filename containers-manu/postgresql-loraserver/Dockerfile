FROM postgres:9.6-alpine
MAINTAINER Asgard Team "manuel.sanchezlopez@altran.com"

COPY ./configuration/postgresql/initdb /docker-entrypoint-initdb.d

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
