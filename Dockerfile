from archlinux:base-devel

COPY mirrorlist /etc/pacman.d/
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm git
RUN pacman -S --noconfirm cargo clang llvm cmake libxcb cairo
RUN pacman -S --noconfirm python

RUN useradd -mG wheel,users aur

WORKDIR /home/aur/work

COPY kime ./kime
COPY kime-bin ./kime-bin
COPY kime-git ./kime-git
COPY docker/update.sh .
COPY docker/replace.py .
RUN chown -R aur:aur /home/aur

USER aur

ENTRYPOINT ["./update.sh"]

