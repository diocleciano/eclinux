#!/bin/bash

# Atualizar o sistema
yum update -y

# Instalar o Docker
yum -y install docker

# Inicia o docker
systemctl start docker.service

# Deixa configurado para iniciar ao ligar a máquina
systemctl enable docker.service
echo "$(systemctl status docker.service)" > /tmp/log_docker.txt
usermod -aG docker $USER

# Instalar o Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
echo "$(docker-compose version)" >> /tmp/log_docker.txt

# Criar diretório "main" na home do usuário EC2 e arquivo docker-compose.yml
mkdir /home/ec2-user/main
cat <<EOT > /home/ec2-user/main/docker-compose.yml
version: '3'
services:
  wordpress:
    image: wordpress:latest
    ports:
      - "80:80"
    environment:
      WORDPRESS_DB_HOST: wordpress.cpvygcqf99au.us-east-1.rds.amazonaws.com
      WORDPRESS_DB_USER: admin
      WORDPRESS_DB_PASSWORD: sssH.senh4
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - /home/ec2-user/main:/var/www/html
EOT

# Dar permissões adequadas para o arquivo docker-compose.yml
chown ec2-user:ec2-user /home/ec2-user/main/docker-compose.yml

# Dar permissões de escrita no diretório main
chmod +w /home/ec2-user/main

# Executar docker-compose no diretório main
su - ec2-user -c "cd /home/ec2-user/main && docker-compose up -d"
