FROM apereo/cas:v5.3.10

COPY etc/cas/ /etc/cas/
COPY etc/cas/config/ /etc/cas/config/
COPY etc/cas/services/ /etc/cas/services/
COPY etc/cas/saml/ /etc/cas/saml/

COPY etc/*.json /cas-overlay/src/main/resources/services/
