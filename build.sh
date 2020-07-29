#!/bin/bash
rm -rf out
mkdir out
git clone clang_url
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 --depth=1 aarch64
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9 --depth=1 aarch32

export KBUILD_JOBS="$((`grep -c '^processor' /proc/cpuinfo`))"
export KBUILD_BUILD_USER=vishalk17
export KBUILD_BUILD_HOST=vishalk17-vm

export ARCH=arm64 && export SUBARCH=arm64

# compilation
make O=out ARCH=arm64 oppo6771_defconfig
make -j8 O=out ARCH=arm64 CC="$(pwd)/clang/bin/clang" CLANG_TRIPLE="aarch64-linux-gnu-" CROSS_COMPILE="$(pwd)/aarch64/bin/aarch64-linux-android-" CROSS_COMPILE_ARM32="$(pwd)/aarch32/bin/arm-linux-androideabi-"
