FROM ubuntu:26.04

ARG REINSTALL_CMAKE_VERSION_FROM_SOURCE="4.3.0"

# Optionally install the cmake for vcpkg
COPY ./reinstall-cmake.sh /tmp/

# [Optional] Uncomment this section to install additional vcpkg ports.
# RUN su vscode -c "${VCPKG_ROOT}/vcpkg install <your-port-name-here>"

# [Optional] Uncomment this section to install additional packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends git ninja-build python3 lsb-release \
    curl wget zip unzip tar ca-certificates openssl software-properties-common gnupg\
    autoconf autoconf-archive automake  build-essential pkg-config libtool '^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev libxkbcommon-dev libxkbcommon-x11-dev libegl1-mesa-dev 

COPY ./install-vcpkg.sh /tmp/
COPY ./reinstall-cmake.sh /tmp/
COPY ./install-clang.sh /tmp/

RUN if [ "${REINSTALL_CMAKE_VERSION_FROM_SOURCE}" != "none" ]; then \
       chmod +x /tmp/reinstall-cmake.sh && /tmp/reinstall-cmake.sh ${REINSTALL_CMAKE_VERSION_FROM_SOURCE}; \
   fi \
   && rm -f /tmp/reinstall-cmake.sh

RUN chmod +x /tmp/install-vcpkg.sh && /tmp/install-vcpkg.sh rm -f /tmp/install-vcpkg.sh
ENV VCPKG_ROOT='/opt/vcpkg'
RUN vcpkg x-update-baseline

# this takes tooooo fucking loooooong that devcontainer just gives up, run this shell script locally when it's done so that it doesn't timeout
# RUN chmod +x /tmp/install-clang.sh && /tmp/install-clang.sh rm -f /tmp/install-clang.sh