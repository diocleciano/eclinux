#!/bin/bash

# Atualizar o sistema
yum update -y

# Instalar o Docker
yum -y install docker

#Inicia o docker
systemctl start docker.service

#Deixa configurado para iniciar ao ligar a maquina
systemctl enable docker.service
echo "$(systemctl status docker.service)" > /tmp/log_docker.txt
usermod -aG docker $USER

# Instalar o Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
echo "$(docker-compose version)" >> /tmp/log_docker.txt
# Criar diretório "main" na home do usuário EC2, vamos usar isso
mkdir /home/ec2-user/main
