FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY ./kubeval /usr/bin/kubeval
CMD ["/usr/bin/kubeval"]
