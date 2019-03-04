# OpenVPN speed tweaking

OpenVPN is among the most popular VPN servers today.

Unfortunately, it seems to come with defaults that considerably lower
maximum throughput.

Here are the tweaks I employ to increase my speed by a factor of 15-30x.

## Server config

    # usually resides in /etc/openvpn
    sndbuf0
    rcvbuf0
    proto udp # instead of tcp

## Client config

    # in your ovpn file (or specify as command-line arguments)
    tun-mtu 8192
    fragment 0
    mssfix 0
    sndbuf 0
    rcvbuf 0
    cipher camellia-128-cbc
    proto udp # instead of tcp

## Casual benchmark

Here are the numbers from speedtest.net, before I employed the tweaks:

    ping 126ms
    dl 0.5mbps
    ul 0.5mbps

And this is afterwards:

    ping 74ms
    dl 15mbps
    ul 1mbps

Besides these numbers, I can regularly see the speed improvements in my
torrent client.
