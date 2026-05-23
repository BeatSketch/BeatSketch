FROM debian

COPY ./resources/ /build
WORKDIR /build
RUN ./prepare.sh

CMD ["./build.sh"]
