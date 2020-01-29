#!/bin/bash

mkfs -t ext4 ${DEVICE}; echo '${DEVICE} /data ext4 defaults 0 0' >> /etc/fstab
mkdir ${MOUNT_POINT}; mount ${DEVICE} ${MOUNT_POINT}