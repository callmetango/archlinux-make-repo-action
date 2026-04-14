# Base image
FROM docker.io/library/archlinux:multilib-devel

# Install dependencies
RUN pacman -Syu --needed --noconfirm pacman-contrib

# Setup user
RUN useradd -m runner && \
    echo 'runner ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
WORKDIR /home/runner
USER runner

# Copy files
#COPY LICENSE README.md /
COPY --chmod=755 entrypoint.sh /entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
