FROM debian:jessie-slim
RUN apt-get update && apt-get install -y ca-certificates

COPY rootfs /

CMD /slack-notify
