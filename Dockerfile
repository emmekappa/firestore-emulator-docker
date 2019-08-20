ARG GCLOUD_SDK_VERSION=258.0.0-alpine
FROM google/cloud-sdk:$GCLOUD_SDK_VERSION
ARG LISTEN_PORT=8080
RUN echo will listen on $LISTEN_PORT

RUN apk add --update --no-cache openjdk8-jre &&\
    gcloud components install cloud-firestore-emulator beta --quiet

WORKDIR /app

COPY start-firestore .

EXPOSE $LISTEN_PORT
ENV FIRESTORE_LISTEN_PORT $LISTEN_PORT
HEALTHCHECK --start-period=5s --interval=10s --retries=4 CMD curl --fail http://localhost:$FIRESTORE_LISTEN_PORT/ || exit 1
ENTRYPOINT ["/app/start-firestore"]
