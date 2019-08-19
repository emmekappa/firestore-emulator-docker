# Google Cloud Datastore Emulator

A [Google Cloud Datastore Emulator](https://cloud.google.com/datastore/docs/tools/datastore-emulator/) container image. The image is meant to be used for creating an standalone emulator for testing.

## Environment variables

The following environment variables must be set:

- `DATASTORE_PROJECT_ID`: The ID of the Google Cloud project for the emulator.

### Emulator options

The following environment variables are used to control emulator options:

- `CONSISTENCY` (default: `0.9`)
- `STORE_ON_DISK` (default: `false`, if `true` the data will be stored in `/opt/data`)

For detail please see: https://cloud.google.com/sdk/gcloud/reference/beta/emulators/datastore/start

## Connect application with the emulator

The following environment variables need to be set so your application connects to the emulator instead of the production Cloud Datastore environment:

- `DATASTORE_EMULATOR_HOST`: The listen address used by the emulator.
- `DATASTORE_PROJECT_ID`: The ID of the Google Cloud project used by the emulator.

## Custom commands

This image contains a script named `start-datastore` (included in the PATH). This script is used to initialize the Datastore emulator.

### Starting an emulator

By default, the following command is called:

```sh
start-datastore
```

## Creating a Datastore emulator with Docker Compose

The easiest way to create an emulator with this image is by using [Docker Compose](https://docs.docker.com/compose). The following snippet can be used as a `docker-compose.yml` for a datastore emulator:

```YAML
version: "2"

services:
  datastore:
    image: singularities/datastore-emulator
    environment:
      - DATASTORE_PROJECT_ID=project-test
      - CONSISTENCY=1.0
    ports:
      - "8081:8081"
```

### Persistence

The image has a volume mounted at `/opt/data`. To maintain states between restarts, mount a volume at this location.

