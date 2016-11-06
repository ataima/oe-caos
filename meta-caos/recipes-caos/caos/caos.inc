

SUMMARY = "CaOS. a baremetl Operating Systems"
HOMEPAGE = "https://github.com/ataima/caos.git"

SRC_URI = "git://github.com/ataima/caos.git"
SRCREV = "${AUTOREV}"

LICENSE = "GPLv3"
LIC_FILES_CHKSUM = "file://GPLV3.txt;md5=d32239bcb673463ab874e80d47fae504"



S = "${WORKDIR}/git/os"
B = "${WORKDIR}/build"

PACKAGE_ARCH = "${MACHINE_ARCH}"


EXTRA_OEMAKE = 'CROSS_COMPILE=${TARGET_PREFIX} CC="${TARGET_PREFIX}gcc ${TOOLCHAIN_OPTIONS}"  CXX="${TARGET_PREFIX}g++ ${TOOLCHAIN_OPTIONS}"V=1'
EXTRA_OEMAKE += 'HOSTCC="${BUILD_CC} ${BUILD_CFLAGS} ${BUILD_LDFLAGS}"'

PV = "1_0"


do_clean(){

rm -rf  -d  "${IMAGE_DIR}"
 
}

do_compile () {
cd $PWD/../git/os
echo "----------------------------------------------------------------------------"
echo $CC"		->\n" $CXX
echo "----------------------------------------------------------------------------"
ls  -al rules.mk
sed -i "s/arm-none-eabi/arm-oe-linux-gnueabi/g" rules.mk
sed -i "s/LK_OPT*/#LK_OPT*/g" rules.mk 
echo "-"
make all
}




do_install () {
rm -rf  -d  "${IMAGE_DIR}"
install -d  "${IMAGE_DIR}"
 install "${S}/build/caOS.bin" "${IMAGE_DIR}/."
 install "${S}/build/caOS.hex" "${IMAGE_DIR}/."
 install "${S}/build/caOS.s" "${IMAGE_DIR}/."
 install "${S}/build/caOS.list" "${IMAGE_DIR}/."
 install "${S}/build/caOS.elf" "${IMAGE_DIR}/."
 
 echo "export PATH=\""> setenv.sh
 echo $PATH >>setenv.sh
 echo ":\$PATh\"">>setenv.sh
 
}


FILES_${PN} = "/"



