#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.68.1/g' package/base-files/files/bin/config_generate
# 去掉默认密码
sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings
#替换默认主题为luci-theme-infinityfreedom
sed -i 's/luci-theme-bootstrap/luci-theme-infinityfreedom/' feeds/luci/collections/luci/Makefile
# 修改默认主机名
#sed -i '/uci commit system/i\uci set system.@system[0].hostname='OpenWrt'' package/lean/default-settings/files/zzz-default-settings
##-----------------Add dev core for kenzo OpenClash------------------
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz -o /tmp/clash.tar.gz
tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
chmod +x /tmp/clash >/dev/null 2>&1
mkdir -p package/kenzo/luci-app-openclash/root/etc/openclash/core
mv /tmp/clash package/kenzo/luci-app-openclash/root/etc/openclash/core/clash >/dev/null 2>&1
rm -rf /tmp/clash.tar.gz >/dev/null 2>&1
