FROM archlinux:base-devel
# update & install applications
RUN pacman -Syu --noconfirm doas sudo git
# makepkg requires non-root user to build packages 
RUN useradd -m builder
# adds the builder user to wheel for sudo, and doa
RUN usermod -aG wheel builder
# allow wheel group to use sudo with no password
RUN printf '%%wheel ALL=(ALL) NOPASSWD: ALL\n' | sudo tee -a /etc/sudoers >/dev/null
# allow wheel group to use doas with no password
RUN printf 'permit nopass :wheel\n' | sudo tee -a /etc/doas.conf >/dev/null