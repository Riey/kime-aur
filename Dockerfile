from archlinux:base-devel

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm git
RUN pacman -S --noconfirm cargo clang llvm cmake libxcb cairo

RUN useradd -mG wheel,users aur

WORKDIR /home/aur/work

COPY kime ./kime
COPY kime-bin ./kime-bin
COPY kime-git ./kime-git
COPY docker/update.sh .
RUN chown -R aur:aur /home/aur

USER aur

ENTRYPOINT ["./update.sh"]

