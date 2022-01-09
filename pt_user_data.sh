#!/bin/bash -vx
#
# Install, configure and start a new Minecraft server
# This supports Ubuntu and Amazon Linux 2 flavors of Linux (maybe/probably others but not tested).

set -e

# Determine linux distro
if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

# Update OS and install start script
ubuntu_linux_setup() {
  export SSH_USER="ubuntu"
  export DEBIAN_FRONTEND=noninteractive
  /usr/bin/apt-get update
  /usr/bin/apt-get -yq install -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" default-jre wget awscli jq
  /bin/cat <<"__UPG__" > /etc/apt/apt.conf.d/10periodic
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
__UPG__

  # Init script for starting, stopping
  cat <<INIT > /etc/init.d/pteroractyl
#!/bin/bash
# Short-Description: Minecraft server

start() {
  echo "Starting pterordactyl server..."
  # TODO: start command here
}

stop() {
  echo "Stopping pterordactyl server..."
  # TODO: stop command here
}

case \$1 in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    stop
    sleep 5
    start
    ;;
esac
exit 0
INIT

  # Start up on reboot
  /bin/chmod +x /etc/init.d/pterodactyl
  /usr/sbin/update-rc.d pterodactyl defaults

}

### download all of the dependencies here
download_pterodactyl_server() {

  WGET=$(which wget)

  # version_manifest.json lists available MC versions
  # $WGET -O ${pt_root}/version_manifest.json https://launchermeta.mojang.com/mc/game/version_manifest.json

}

# Create mc dir, sync S3 to it and download mc if not already there (from S3)
/bin/mkdir -p ${pt_root}
/usr/bin/aws s3 sync s3://${pt_bucket} ${pt_root}

# Download server if it doesn't exist on S3 already (existing from previous install)
# To force a new server version, remove the server JAR from S3 bucket
#

# Cron job to sync data to S3 every five mins
/bin/cat <<CRON > /etc/cron.d/minecraft
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:${pt_root}
*/${pt_backup_freq} * * * *  $SSH_USER  /usr/bin/aws s3 sync ${pt_root}  s3://${pt_bucket}
CRON

# Not root
/bin/chown -R $SSH_USER ${pt_root}

# Start the server
case $OS in
  Ubuntu*)
    /etc/init.d/pteroractyl start
    ;;
esac

exit 0
