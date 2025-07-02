set -x
dirname_in_trunk=${PWD}/camera

function copy_driver_code_to_linux()
{
    cd ${dirname_in_trunk}/kernel
    KERNEL_VER=$(make kernelversion)
    if [ "$(printf "6.10\n$(make kernelversion)" | sort -V | head -n1)" != "6.10" ]; then
        UPSTREAM=false
    else
        UPSTREAM=true
    fi
    cd -

    cd ${dirname_in_trunk}/drivers/scripts/strip/ipu6_linux
    PATH=${PATH}:${PWD}/../ KERNEL_VER=${KERNEL_VER} UPSTREAM=${UPSTREAM} ./strip_code.sh ${dirname_in_trunk}/drivers ${dirname_in_trunk}/tmp_drivers_upstream
    if [ $? -ne 0 ];then echo "error in strip_code.sh"; return 1; fi

    cd -
    cp -rv ${dirname_in_trunk}/tmp_drivers_upstream/* ${dirname_in_trunk}/kernel/ && rm -r ${dirname_in_trunk}/tmp_drivers_upstream/
    echo "obj-\$(CONFIG_VIDEO_INTEL_IPU6)  += psys/" >> ${dirname_in_trunk}/kernel/drivers/media/pci/intel/ipu6/Makefile

    cp -rv ${dirname_in_trunk}/drivers/patches/*.diff ${dirname_in_trunk}/kernel/
    cd ${dirname_in_trunk}/kernel/
    #patch -p1 < 0001-media-i2c-Add-ar0234-camera-sensor-driver.diff
    #patch -p1 < 0002-media-i2c-add-support-for-lt6911uxe.diff
    #patch -p1 < 0003-INT3472-Support-LT6911UXE.diff
    #patch -p1 < 0004-upstream-Use-module-parameter-to-set-isys-freq.diff
    #patch -p1 < 0005-upstream-Use-module-parameter-to-set-psys-freq.diff
    #patch -p1 < 0006-media-pci-Enable-ISYS-reset.diff
    #patch -p1 < 0007-media-i2c-add-support-for-ar0234-and-lt6911uxe.diff
    #patch -p1 < 0008-driver-media-i2c-remove-useless-header-file.diff
    #patch -p1 < 0010-media-i2c-update-lt6911uxe-driver-for-upstream-and-b.diff

    git am 0001-media-i2c-Add-ar0234-camera-sensor-driver.diff
    git am 0002-media-i2c-add-support-for-lt6911uxe.diff
    git am 0003-INT3472-Support-LT6911UXE.diff
    git am 0004-upstream-Use-module-parameter-to-set-isys-freq.diff
    git am 0005-upstream-Use-module-parameter-to-set-psys-freq.diff
    patch -p1 < 0006-media-pci-Enable-ISYS-reset.diff
    git am 0007-media-i2c-add-support-for-ar0234-and-lt6911uxe.diff
    git am 0008-driver-media-i2c-remove-useless-header-file.diff
    git am 0010-media-i2c-update-lt6911uxe-driver-for-upstream-and-b.diff

    cp ${dirname_in_trunk}/../0001*.patch ${dirname_in_trunk}/kernel/
    
    git am 0001-media-i2c-change-ub960-and-ub953-driver-to-enable-im.patch
    rm -r *.patch

    if [ $? -ne 0 ];then echo "-------error---------"; fi

    rm -r *.diff

    return 0
}

function run_kernel_build() {
    #copy_driver_code_to_linux
    #if [ $? -eq 1 ]; then
    #    return 22
    #fi

    #cp ${dirname_in_trunk}/../0001*.patch ${dirname_in_trunk}/package/
    #cd ${dirname_in_trunk}/package/
    #git am 0002-package-add-DS90UB953-DS90UB960-and-IMX390.patch
    #rm -r *.patch

    # cd ${dirname_in_trunk}/kernel/
    cd ${dirname_in_trunk}/kernel-lts/
    export ARCH=x86_64

    echo "*********************************"
    gcc --version
    echo "*********************************"

    # KERNEL_BUILD_LABEL="-maxim-serdes"
    KERNEL_BUILD_LABEL="-vtg-gmsl"
    # CC="ccache gcc"

    #cp ${dirname_in_trunk}/package/config_linux_mainline .config
    #cp kernel.config .config
    #rm -rf ${dirname_in_trunk}/kernel/*.tar.bz2 ${dirname_in_trunk}/*.deb ${dirname_in_trunk}/*.buildinfo ${dirname_in_trunk}/*.changes
    #rm -rf ${dirname_in_trunk}/out
    #make mrproper
    #make kernelversion
    # echo "" | make -j$(nproc) LOCALVERSION=${KERNEL_BUILD_LABEL} oldconfig
    make -j$(nproc) LOCALVERSION=${KERNEL_BUILD_LABEL}
    # make -j$(nproc) LOCALVERSION=${KERNEL_BUILD_LABEL} bindeb-pkg
    rv_build=$?
    #if [ $rv_build -ne 0 ]; then
    #    echo "build script returned fail"
    #    rm -rf ${dirname_in_trunk}/kernel/*.tar.bz2 ${dirname_in_trunk}/*.deb ${dirname_in_trunk}/*.buildinfo ${dirname_in_trunk}/*.changes
    #    return 23
    #fi

    return $rv_build
}

#cd ${dirname_in_trunk}/package
#git reset --hard && git clean -df
#cd ${dirname_in_trunk}/drivers
#git reset --hard && git clean -df
#cd ${dirname_in_trunk}/kernel
#git reset --hard && git clean -df
#make mrproper

run_kernel_build
