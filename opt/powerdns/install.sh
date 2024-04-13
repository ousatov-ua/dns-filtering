export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=clang
export CXX="clang++"
export CFLAGS="-O3 -pipe -march=znver3 -flto"
export CXXFLAGS="-O3 -pipe -march=znver3 -flto"
export CPPFLAGS="-O3 -pipe -march=znver3 -flto"

./configure --enable-dnstap --enable-lto --enable-systemd --with-libcap
make
