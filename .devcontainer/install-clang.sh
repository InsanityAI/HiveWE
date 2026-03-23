# Download llvm+clang
wget qO llvm.tar.gz https://github.com/llvm/llvm-project/releases/download/llvmorg-22.1.0/clang+llvm-22.1.0-armv7a-linux-gnueabihf.tar.gz

#unpack llvm+clang
mkdir /opt/llvm
tar xf llvm.tar.gz --strip-components=1 -C /opt/llvm

# In /usr/local/bin directory, we can create a symbolic link to the clang command:
ln -s /opt/llvm/bin/clang /usr/local/bin/clang
ln -s /opt/llvm/bin/clang-scan-deps /usr/local/bin/clang-scan-deps
ln -s /opt/llvm/bin/clang-scan-deps /usr/local/bin/clang-scan-deps-21
rm llvm.tar.gz