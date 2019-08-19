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

ENTRYPOINT ["/app/start-datastore"]
