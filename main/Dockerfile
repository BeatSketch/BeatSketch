FROM archlinux

RUN pacman -Sy wine wget git python-pip unzip zip --noconfirm
COPY ./setup.sh /build/setup.sh
WORKDIR /build
RUN chmod +x setup.sh
RUN ./setup.sh

COPY ./prepare.sh /build/prepare.sh
RUN chmod +x prepare.sh
RUN ./prepare.sh

COPY ./resources/ /build
RUN chmod +x ./build.sh
RUN chmod +x ./vr/build.sh

CMD ["/build/build.sh"]
