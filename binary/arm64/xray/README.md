# [XRary](https://github.com/XTLS/Xray-core)

Project X originates from XTLS protocol, provides a set of network tools such as Xray-core and Xray-flutter.

## RULES
> V2Ray 路由规则文件加强版，可代替 V2Ray 官方 geoip.dat 和 geosite.dat
> https://github.com/Loyalsoldier/v2ray-rules-dat

## 二进制存放
> 由于路由器jffs空间有限，此处存放经过UPX压缩的xray二进制，以节约空间
> upx要求必须为官方最新源代码编译版本，大部分发行版均存在bug
> 压缩命令：
>   `upx --lzma --best xray -oxray xray_armv7l`
>   `upx --lzma --ultra-brute -oxray xray_armv7l`