#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# 添加第三方软件包
#git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
#git clone https://github.com/kenzok8/small-package package/small-package
[ -d package/UA2F ] || git clone --depth 1 https://github.com/Zxilly/UA2F package/UA2F

# nikki feed
grep -q 'nikki' feeds.conf.default || echo 'src-git nikki https://github.com/nikkinikki-org/OpenWrt-nikki.git' >> feeds.conf.default

# 启用 kmod-nft-socket 和 kmod-nf-socket 所需的内核配置
grep -q 'CONFIG_NF_SOCKET_IPV4=m' target/linux/generic/config-5.4 || \
    sed -i 's/# CONFIG_NF_SOCKET_IPV4 is not set/CONFIG_NF_SOCKET_IPV4=m/' target/linux/generic/config-5.4
grep -q 'CONFIG_NF_SOCKET_IPV6=m' target/linux/generic/config-5.4 || \
    sed -i 's/# CONFIG_NF_SOCKET_IPV6 is not set/CONFIG_NF_SOCKET_IPV6=m/' target/linux/generic/config-5.4
grep -q 'CONFIG_NFT_SOCKET=m' target/linux/generic/config-5.4 || \
    sed -i 's/# CONFIG_NFT_SOCKET is not set/CONFIG_NFT_SOCKET=m/' target/linux/generic/config-5.4

# tailscale (每次拉取最新版本)
rm -rf package/openwrt-tailscale package/luci-app-tailscale-community
git clone --depth 1 https://github.com/GuNanOvO/openwrt-tailscale package/openwrt-tailscale
git clone --depth 1 https://github.com/Tokisaki-Galaxy/luci-app-tailscale-community package/luci-app-tailscale-community

# 升级 golang 到 1.24 (tailscale 1.94+ 需要)
rm -rf feeds/packages/lang/golang
git clone --depth 1 -b 24.x https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang