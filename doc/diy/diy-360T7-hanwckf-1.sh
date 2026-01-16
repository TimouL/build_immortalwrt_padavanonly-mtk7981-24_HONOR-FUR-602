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
git clone https://github.com/Zxilly/UA2F package/UA2F

# 添加 nikki feeds
echo 'src-git nikki https://github.com/nikkinikki-org/OpenWrt-nikki.git' >> feeds.conf.default

# 启用 kmod-nft-socket 和 kmod-nf-socket 所需的内核配置
# 这些模块是 nikki 的依赖项
sed -i 's/# CONFIG_NF_SOCKET_IPV4 is not set/CONFIG_NF_SOCKET_IPV4=m/' target/linux/generic/config-5.4
sed -i 's/# CONFIG_NF_SOCKET_IPV6 is not set/CONFIG_NF_SOCKET_IPV6=m/' target/linux/generic/config-5.4
sed -i 's/# CONFIG_NFT_SOCKET is not set/CONFIG_NFT_SOCKET=m/' target/linux/generic/config-5.4