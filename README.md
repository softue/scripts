# scripts

Small scripts for a better admin life

## check-vpn.sh

Script reinicia serviço VPN IPSEC do Firewall da Blockbit caso servidor da rede VPN não esteja respondendo

### Instalação

Comandos para baixar, instalar e incluir a chamado no cron

```
wget https://raw.githubusercontent.com/softue/scripts/master/check-vpn.sh -O /root/check-vpn.sh && chmod +x /root/check-vpn.sh && cat <(crontab -l) <(echo "*/1 * * * * /root/vpn-test.sh") | crontab -
```

### Configurar as variáveis de ambiente

```vi /root/check-vpn.sh```
* SSH_PASS: senha do ssh (ssh password)
* SSH_USER: usuário do ssh (ssh username)
* SSH_IP: IP do servidor ssh
* VPN_IP: IP do host na VPN que está sendo monitorado
