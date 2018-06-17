#!/bin/bash
### Srijith Bharadwaj (srijithdamerla2001@gmail.com)
### A custom build script to build zImage
set -e
## Copy this script inside the kernel directory

KERNEL_DIR=$PWD
KERNEL_TOOLCHAIN=$KERNEL_DIR/toolchain-4.9/bin/arm-eabi-
KERNEL_DEFCONFIG=lineageos_k9_defconfig
JOBS=8

# The MAIN Part
echo "**** Setting Toolchain ****"
export CROSS_COMPILE=$KERNEL_TOOLCHAIN
export ARCH=arm

# Clean build always lol
echo "**** Cleaning ****"
make clean && make mrproper

echo "**** Kernel defconfig is set to $KERNEL_DEFCONFIG ****"
make $KERNEL_DEFCONFIG
make -j$JOBS

echo "**** Build is completed ****"
echo "Get zImage from arch/arm/boot"
