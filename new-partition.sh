#!/bin/bash

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Disk to partition
DISK="/dev/sdb"

# Check if the disk exists
if [ ! -b $DISK ]; then
    echo "Disk $DISK does not exist."
    exit 1
fi

# Create a new partition table
echo "Creating new partition table on $DISK"
parted $DISK mklabel gpt

# Create a new partition with 30 GB
echo "Creating a 30 GB partition on $DISK"
parted $DISK mkpart primary ext4 1MiB 30GiB

# Format the new partition
PARTITION="${DISK}1"
echo "Formatting $PARTITION to ext4"
mkfs.ext4 $PARTITION

# Mount the partition (optional, modify the mount point as needed)
MOUNT_POINT="/mnt/lfs"
echo "Mounting $PARTITION to $MOUNT_POINT"
mkdir -p $MOUNT_POINT
mount $PARTITION $MOUNT_POINT

# Add entry to /etc/fstab (optional)
echo "$PARTITION    $MOUNT_POINT    ext4    defaults    0    0" >> /etc/fstab

echo "Partitioning and mounting completed."

