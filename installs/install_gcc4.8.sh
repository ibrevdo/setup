#!/bin/bash
set -xe

BASE_URL=http://ftp.us.debian.org/debian/pool/main/
PACKAGES=$(cat <<-END
g/gcc-4.8/cpp-4.8_4.8.4-1_amd64.deb
g/gcc-4.8/g%2B%2B-4.8_4.8.4-1_amd64.deb
g/gcc-4.8/gcc-4.8-base_4.8.4-1_amd64.deb
g/gcc-4.8/gcc-4.8_4.8.4-1_amd64.deb
g/gcc-4.8/libgcc-4.8-dev_4.8.4-1_amd64.deb
g/gcc-4.8/libasan0_4.8.4-1_amd64.deb
g/gcc-4.8/libstdc%2B%2B-4.8-dev_4.8.4-1_amd64.deb
m/mpfr4/libmpfr4_3.1.5-1_amd64.deb
c/cloog/libcloog-isl4_0.18.4-1+b1_amd64.deb
i/isl/libisl10_0.12.2-2_amd64.deb
i/isl/libisl15_0.18-1_amd64.deb
END
)

mkdir -p ./downloads/gcc4.8
cd ./downloads/gcc4.8

sudo aptitude install multiarch-support
sudo dpkg -i ./*.deb
