#!/usr/bin/bash
#
# Process to backup haproxy to a manta object storage server

# Assumes you have a valid set of MANTA environment variables for this to work

export INSTANCE_SHORTNAME=`/usr/sbin/mdata-get sdc:uuid | cut -f 1 -d -`
export TIME=`date +%s_%Y_%m_%d`
# This generates a highly likely unique directory per instance you are running
# It exists so that if you do a restore of your data, the whole point of
# backups, and then the restored running instance takes a backup, it doesn't
# land on the original's backup directory.

# stage 0, create the directory in manta where I'm storing the backups
mmkdir -p ~~/stor/backups/haproxy/${INSTANCE_SHORTNAME:?}

# stage 1, tar up the files and send them to manta
tar -cz /root/.acme.sh/ /opt/local/etc/certs /opt/local/etc/haproxy.cfg | mput ~~/stor/backups/haproxy/${INSTANCE_SHORTNAME:?}/${TIME:?}.haproxy.config.tgz

