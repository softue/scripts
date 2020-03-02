#!/bin/bash

#    Script reinicia serviço VPN IPSEC do Firewall da Blockbit caso servidor da rede VPN não esteja respondendo
#    Copyright (C) 2020 - Rômulo Mendes Figueiredo
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

SSH_PASS=""
SSH_USER=""
SSH_IP=""
VPN_IP=""

restart_server()
{
echo "restarting server..."
sshpass -p $SSH_PASS ssh -tt $SSH_USER@$SSH_IP << EOF
service-stop vpn-ipsec
service-start vpn-ipsec
exit
EOF
}

check_ip()
{
ping -q -c 5 $1 > /dev/null

if [ $? -ne 0 ]
then
  echo "no vpn connection"
  restart_server
fi
}

check_ip $VPN_IP
