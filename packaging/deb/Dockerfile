FROM debian

COPY . prepare.sh
RUN ./prepare.sh
COPY . build.sh

CMD ["./build.sh"]
