FROM golang:1.22.4-alpine3.20

ARG ARCH

ENV SYFT_VERSION="v1.8.0" \
    SYFT_INSTALL_SCRIPT_URL=https://raw.githubusercontent.com/anchore/syft/main/install.sh \
    SYFT_INSTALL_DIR=/usr/local/bin \
    SYFT_INSTALL_SCRIPT_TEMP=/tmp/install.sh \
    CURL_VERSION="8.8.0-r0" \
    BASH_VERSION="5.2.26-r0"
    
RUN apk --no-cache add curl="${CURL_VERSION}" bash="${BASH_VERSION}"

SHELL ["/bin/bash", "-c"]

# hadolint ignore=DL3020
ADD ${SYFT_INSTALL_SCRIPT_URL} ${SYFT_INSTALL_SCRIPT_TEMP}

RUN chmod +x ${SYFT_INSTALL_SCRIPT_TEMP} \
    && ${SYFT_INSTALL_SCRIPT_TEMP} -b ${SYFT_INSTALL_DIR} ${SYFT_VERSION} \
    && rm ${SYFT_INSTALL_SCRIPT_TEMP}

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

RUN addgroup --system --gid 1002 bitbucket-group && \
  adduser --system --uid 1002 --ingroup bitbucket-group bitbucket-user

USER bitbucket-user

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
