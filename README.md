# Central Authentication Service (CAS) [![License](https://img.shields.io/hexpm/l/plug.svg)](https://github.com/Jasig/cas/blob/master/LICENSE)

## Introduction
This repo hosts the [Docker](https://www.docker.com/) build configuration to run CAS with predefined users over http or https. See the `Dockerfile` for more info.

This docker image is intended for development use only. Specifically, when developing a CAS authentication client and a production CAS installation is not accessible, this Docker container provides that service locally. Do not use this image in production.


## Configuration

### Image
* The image will be available on the host via ports `8080` and `8443`
* The image may be accessed via the host browser

## CAS Overlay
* The build will automatically copy the contents of the `src\main\webapp` to the docker image.

### SSL
* The default keystore is `etc/thekeystore`.
* The password for the keystore is `changeit`.

## Run

```bash
docker run -p 8080:8080 -p 8443:8443 -d --name="cas" thewidgetsmith/cas-devl
```

## Usage

### Users
You can login using any of the users defined in `cas.properties`.

Users and passwords are defined with the following line:

```
accept.authn.users=admin1::admin1,admin2::admin2,admin3::admin3
```

Additional users and passwords can be appended to this line.

## Notes

### Generate New Certificate

```
keytool -genkeypair -alias cas -keyalg RSA -keypass changeit -storepass changeit -keystore ./thekeystore -dname "CN=cas.example.org,OU=Example,OU=Org,C=AU" -ext SAN="dns:example.org,dns:localhost,ip:127.0.0.1"
```
