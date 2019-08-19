ARG GCLOUD_SDK_VERSION=258.0.0-alpine
FROM google/cloud-sdk:$GCLOUD_SDK_VERSION

# Install Java 8 for Datastore emulator
RUN apk add --update --no-cache openjdk8-jre &&\
    gcloud components install cloud-datastore-emulator beta --quiet

# Volume to persist Datastore data
VOLUME /opt/data

WORKDIR /app

COPY start-datastore .

EXPOSE 8081
ENV DATASTORE_LISTEN_PORT 8081
ENV CONSISTENCY 0.9
ENV STORE_ON_DISK false
HEALTHCHECK --start-period=5s --interval=10s --retries=4 CMD curl --fail http://localhost:8081/ || exit 1
ENTRYPOINT ["/app/start-datastore"]
