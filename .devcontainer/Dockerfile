# Build HiveWE on Arch Linux with Clang 22+ (supports C++ modules)
FROM archlinux:latest

# Initialize pacman keyring and install minimal build essentials
RUN pacman-key --init && \
    pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
    base-devel \
    clang \
    extra/llvm \
    libc++ \
    libc++abi \
    lld \
    cmake \
    ninja \
    git \
    curl \
    zip \
    unzip \
    tar \
    mesa \
    python \
    perl && \
    pacman -Sc --noconfirm

ENV CC=/usr/bin/clang \
    CXX=/usr/bin/clang++ \
    AR=/usr/bin/llvm-ar \
    RANLIB=/usr/bin/llvm-ranlib \
    LD=/usr/bin/lld \
    VCPKG_ROOT=/vcpkg

RUN chmod +x compile-libcpp.sh && compile-libcpp.sh

WORKDIR /src
COPY . .

# Clone vcpkg and fetch specific baseline
RUN git clone --depth 1 https://github.com/Microsoft/vcpkg.git /vcpkg && \
    cd /vcpkg && \
    git fetch --depth 1 origin 9cbe1df2acf09b1d53cf6e48afa5fda44f61147d || git fetch origin 9cbe1df2acf09b1d53cf6e48afa5fda44f61147d && \
    git checkout 9cbe1df2acf09b1d53cf6e48afa5fda44f61147d && \
    /vcpkg/bootstrap-vcpkg.sh -disableMetrics

# Build
RUN mkdir -p /src/build && \
    cd /src/build
    # cmake -DCMAKE_BUILD_TYPE=Release \
    #       -DCMAKE_C_COMPILER=/usr/bin/clang \
    #       -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
    #       -DCMAKE_AR=/usr/bin/llvm-ar \
    #       -DCMAKE_RANLIB=/usr/bin/llvm-ranlib \
    #       -DCMAKE_LINKER=/usr/bin/lld \
    #       -DCMAKE_TOOLCHAIN_FILE=/vcpkg/scripts/buildsystems/vcpkg.cmake \
    #       -DVCPKG_TARGET_TRIPLET=x64-linux \
    #       -GNinja \
    #       .. && \
    # cmake --build . --config Release -j$(nproc)

# Binary location: /src/build/HiveWE
# ENTRYPOINT ["/src/build/HiveWE"]