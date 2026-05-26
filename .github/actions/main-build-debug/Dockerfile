FROM ghcr.io/beatsketch/build

WORKDIR /build
COPY ./build.sh /build/build.sh
RUN chmod +x /build/build.sh

ENTRYPOINT ["/build/build.sh"]
