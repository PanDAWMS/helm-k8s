FROM alpine

RUN apk update
RUN apk add --no-cache mariadb-client
COPY get_init_batchid.sh /usr/get_init_batchid.sh
ENTRYPOINT ["/bin/sh"]
CMD ["/usr/get_init_batchid.sh"] 
