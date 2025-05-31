FROM archlinux:latest

# Update system and install base packages
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

# Create a non-root user
RUN useradd -m -s /bin/bash archuser && \
    echo 'archuser:password' | chpasswd && \
    usermod -aG wheel archuser

# Configure sudo (optional, for development)
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Set up XFCE environment
USER archuser
WORKDIR /home/archuser

# Create .xinitrc for starting XFCE
RUN echo 'exec startxfce4' > /home/archuser/.xinitrc

# Set environment variables
ENV DISPLAY=:0
ENV USER=archuser
ENV HOME=/home/archuser

# Create a startup script that can launch different applications
COPY --chown=archuser:archuser arch_startup.sh /home/archuser/startup.sh
RUN chmod +x /home/archuser/startup.sh

# Default command - can be overridden
CMD ["/home/archuser/startup.sh"]