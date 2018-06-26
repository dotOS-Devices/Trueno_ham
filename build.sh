#!/bin/bash
### Prema Chand Alugu (premaca@gmail.com)
### Shivam Desai (shivamdesaixda@gmail.com)
### Martichou (martichou.andre@gmail.com)
### A custom build script to build zImage & DTB(Anykernel2 method)
set -e
## Copy this script inside the kernel directory

KERNEL_DIR=$PWD
KERNEL_TOOLCHAIN=$KERNEL_DIR/toolchain-4.9/bin/arm-eabi-
KERNEL_DEFCONFIG=StarCity_defconfig
DTBTOOL=$KERNEL_DIR/tools/dtbtool
JOBS=8
FINAL_KERNEL_ZIP=StarCity_ham.zip
DTBIMAGE="dtb"

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

# Time for dtb
echo "**** Generating DT.IMG ****"
$DTBTOOL/dtbToolCM -2 -o $KERNEL_DIR/arch/arm/boot/$DTBIMAGE -s 2048 -p scripts/dtc/ arch/arm/boot/

echo "**** Verify zImage & dtb ****"
ls $KERNEL_DIR/arch/arm/boot/zImage
ls $KERNEL_DIR/arch/arm/boot/$DTBIMAGE

echo "**** Build Successful ****"
