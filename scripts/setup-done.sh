#!/bin/bash
#
#%stage: boot
#%depends: progs sharedlibs
#

pushd . > /dev/null 2>&1
cd $tmp_mnt
find bin sbin -type f -print0 | xargs -0 chmod 0755
find . ! -name "*~" | cpio -H newc --create | gzip -9 > $tmp_initrd.gz
popd > /dev/null 2>&1
if ! cp -f $tmp_initrd.gz $initrd_image ; then
    oops 8 "Failed to install initrd"
fi
rm -rf $tmp_mnt
