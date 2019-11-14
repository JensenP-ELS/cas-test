# Central Authentication Service (CAS) for local testing and development

This image is **NOT** intended for a production environment.

This image contains a pre-configured [CAS][0] service instance useful for a development and/or testing environment. It is intended for use on a developer machine to run a local CAS service where an authentication client is being developed and/or tested. As such, it is configured to allow all services over HTTP or HTTPS and user credentials are defined as a static configuration in the `cas.properties` file.

## How to use this image

Use this image only in a development/testing scenario.

### Start a CAS server instance

Starting a CAS instance is done on the command line:

```bash
docker run -p 8080:8080 -p 8443:8443 -d --name=cas utahstate/cas-devl:tag
```

Be sure to replace `tag` with the CAS version desired. See the [Tags][1] tab for supported CAS versions.

### Include in docker-compose

Example `docker-compose.yml` for `cas`:

```yml
version: '3'

services:
  cas:
    image: utahstate/cas-devl:v5.3.10
    ports:
      - 8080:8080
      - 8443:8443
```

Run `docker-compose up`, wait for it to initialize, and then visit `http://localhost:8080`.

## User Credentials

User login credentials are defined in `cas.properties`.

### Adding/Changing user credentials

Default user credentials are as follows:

```
cas.authn.accept.users=admin1::admin1,admin2::admin2,admin3::admin3
```

Default user credentials can be replaced by mounting a different `cas.properties` file containing the desired user credentials.

Example `docker-compose.yml` file using a different `cas.properties` file:

```yml
version: '3'

services:
  cas:
    image: utahstate/cas-devl:v5.3.10
    ports:
      - 8080:8080
      - 8443:8443

volumes:
  - ./cas.properties:/etc/cas/config/cas/properties
```

This assumes that the new `cas.properties` file is located in the same directory as the `docker-compose.yml` file.

## Additional Notes

### Generate New Certificate

The keystore is located at `etc/cas/thekeystore` and was generated using the following command:

```
keytool -genkeypair -alias cas -keyalg RSA -keypass changeit -storepass changeit -keystore ./thekeystore -dname "CN=cas.example.org,OU=Example,OU=Org,C=AU" -ext SAN="dns:example.org,dns:localhost,ip:127.0.0.1"
```

[0]: https://www.apereo.org/projects/cas
[1]: https://hub.docker.com/repository/docker/utahstate/cas-devl/tags
