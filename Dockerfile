FROM fedora:23
MAINTAINER Nick Coghlan <ncoghlan@gmail.com>

# NOTE: This is intended for use as the basis of a local stateful container,
#       although it could likely also be used as a build container

# RPM build tools
RUN dnf install -y fedora-packager rpmdevtools

# VCS clients
RUN dnf install -y git mercurial subversion

# C/C++ build tools
RUN dnf install -y gcc

# Python build tools
RUN dnf install -y python-pip python-setuptools python-wheel pyp2rpm

# Autodeps for Python distributions
RUN dnf copr enable -y ngompa/rpm-depgen-pythoneggs && \
    dnf install -y rpm-depgen-pythondistdeps

# Set up to create RPMs
RUN rpmdev-setuptree

# Set a useful default locale
RUN echo "export LANG=en_US.utf-8" > /opt/export_LANG.sh
ENV BASH_ENV=/opt/export_LANG.sh \
    ENV=/opt/export_LANG.sh \
    PROMPT_COMMAND="source /opt/export_LANG.sh"

# Intended for interactive use
CMD bash
