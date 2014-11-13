#!/bin/bash

IMAGEFILE=$1

INJECTINGFILE=$2

WORKDIR=mountedrootfs

SECTOR=`gdisk -l inocybe_spore_1.0.0.bin | grep ROOT | awk '{ print $2 }'`

OFFSET=`expr $SECTOR \* 512`

echo $OFFSET

mkdir -p $WORKDIR
sudo mount -t btrfs -o offset=$OFFSET $IMAGEFILE $WORKDIR

sudo mkdir -p "${WORKDIR}/var/lib/coreos-install"
sudo cp $INJECTINGFILE $WORKDIR/var/lib/coreos-install/user-data

sudo umount ${WORKDIR}

rmdir ${WORKDIR}
