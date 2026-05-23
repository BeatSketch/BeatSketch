FROM archlinux

RUN pacman -Sy wine wget rpm-tools git python-pip --noconfirm
COPY ./resources/ /build
WORKDIR /build
RUN ls -la
RUN ./prepare.sh

CMD ["bash", "-c", "./build.sh"]
