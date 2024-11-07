#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/misc/build.func)
# Copyright (c) 2024 Mihai Ionita
# Author: mionita1980
# License: MIT
# https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
   _____                 _              _____                          
  / ____|               | |            / ____|                         
 | (___   __ _ _ __ ___ | |__   __ _  | (___   ___ _ ____   _____ _ __ 
  \___ \ / _` | '_ ` _ \| '_ \ / _` |  \___ \ / _ \ '__\ \ / / _ \ '__|
  ____) | (_| | | | | | | |_) | (_| |  ____) |  __/ |   \ V /  __/ |   
 |_____/ \__,_|_| |_| |_|_.__/ \__,_| |_____/ \___|_|    \_/ \___|_|   

EOF
}
header_info
echo -e "Loading..."
APP="Samba"
var_disk="3"
var_cpu="1"
var_ram="1024"
var_os="debian"
var_version="12"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function update_script() {
header_info
if [[ ! -f /etc/samba/smb.conf ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
msg_info "Updating ${APP} LXC"
apt-get update &>/dev/null
apt-get -y upgrade &>/dev/null
msg_ok "Updated ${APP} LXC"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${APP} should be reachable by going to the following IP (using a Samba client).
         ${BL}${IP}${CL} \n"
