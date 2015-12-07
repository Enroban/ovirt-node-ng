lang en_US.UTF-8
keyboard us
timezone --utc Etc/UTC
auth --enableshadow --passalgo=sha512
selinux --permissive
network --bootproto=dhcp
firstboot --reconfig

rootpw --lock
user --name=node --lock

poweroff

clearpart --all --initlabel # --disklabel=gpt
bootloader --timeout=1
autopart --type=thinp --fstype=ext4

#
# The trick is to loop in the squashfs image as a device
# from the host
#
liveimg --url="file:///mnt/livesrc/LiveOS/rootfs.img"

%pre
# Assumption: A virtio device with the serial livesrc is passed, pointing
# to the squashfs on the host.
mkdir -p /mnt/livesrc
mount /dev/disk/by-id/virtio-livesrc /mnt/livesrc
%end