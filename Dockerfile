FROM archlinux:latest

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
    xorg-server \
    xorg-apps \
    xorg-xinit \
    xfce4 \
    xfce4-goodies \
    firefox \
    thunar \
    xfce4-terminal \
    mousepad \
    git \
    vim \
    htop \
    base-devel \
    && pacman -Scc --noconfirm

RUN useradd -m -s /bin/bash archuser && \
    echo 'archuser:password' | chpasswd && \
    usermod -aG wheel archuser

RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Set up XFCE environment
USER archuser
WORKDIR /home/archuser
RUN echo 'exec startxfce4' > /home/archuser/.xinitr
ENV DISPLAY=:0
ENV USER=archuser
ENV HOME=/home/archuser

COPY --chown=archuser:archuser arch_startup.sh /home/archuser/startup.sh
RUN chmod +x /home/archuser/startup.sh

CMD ["/home/archuser/startup.sh"]