#!/bin/bash

while [ ! -f ${DEVICE} ]
do
  sleep 5
done
ls -ahl ${DEVICE}

FS_TYPE=$(file -s ${DEVICE} | awk '{print $2}')
MOUNT_POINT=/data
echo "$FS_TYPE <--- is defined here"
# If no FS, then this output contains "data"
if [ "$FS_TYPE" = "data" ]
then
    echo "Creating file system on ${DEVICE}" > /tmp/mkfs_creation.txt
    mkfs -t ext4 ${DEVICE} >> /tmp/mkfs_creation.txt
    echo '/dev/${DEVICE} /data ext4 defaults 0 0' >> /etc/fstab
else
    echo "FS_TYPE is not defined" > /tmp/mkfs_creation.txt
fi

mkdir $MOUNT_POINT
mount ${DEVICE} $MOUNT_POINT