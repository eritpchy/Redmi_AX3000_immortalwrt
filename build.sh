#!/bin/bash
set -xe
cd ${0%/*}
export $(grep -v '^#' "docker/.env" | xargs) || true
git config --global --add safe.directory '*'
git checkout include/feeds.mk
# ./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a

cat <<EOF | sed -E 's/^  //' >.config
CONFIG_TARGET_qualcommax=y
CONFIG_TARGET_qualcommax_ipq50xx=y

CONFIG_IB=y
# CONFIG_IB_STANDALONE is not set
CONFIG_SDK=y
CONFIG_MAKE_TOOLCHAIN=y

CONFIG_ALL_NONSHARED=y
CONFIG_REPRODUCIBLE_DEBUG_INFO=y

CONFIG_PACKAGE_luci=y
CONFIG_CCACHE=y
CONFIG_DEVEL=y
EOF
make defconfig
make -j32 V=s download || make -j1 V=s download
make -j$(nproc) tools/install || make -j1 tools/install 
make -j$(nproc) toolchain/install || make -j1 toolchain/install 
make -j$(nproc) || make -j1 V=s 