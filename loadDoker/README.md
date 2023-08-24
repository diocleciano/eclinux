# Atividade sobre docker na AWS

***Proposta:***
 Criar um sistema de instancias EC2 com auto scaling e load balancer que disponibilizem uma aplicaçao de wordpress usando docker.
 
  > **Guia geral**:
**Criar**  banco de dados (esperar para pegar o dns),
**Fazer diretorio**  efs (pegar os dados nescessários),
Pra ** facilitar**  a vida o arquivo.sh ja cria diretorio, monta o efs e faz o docker compose
**Subir** container


**Recursos usados na AWS:**
- **VPC** - Rede de internet da aws;
- **RDS** - Para banco de dados;
- **EC2** - Criar instancias com linux;
- **EFS** - Sistema de compartilhamento de diretórios compatíveis apenas com imagens linux.

> Vamos seguir os seguintes passos nesta ordem para criarmos tudo de forma rapida, como já fiz um passo a passo de criação de VPC anteriormente vou utilizar ela para esta também, ela esta com todo trafego de entrada liberado para o SG *(Security Group)* das instancias. 

### Guia para usar o github durante a criação:
**verificar alterações:**
```git status```

**adicionar todos os arquivos modificados(se for um especifico troque o "." pelo nomde do arquivo) :**
```git add .```

**#adicionar o commit:**
```git commit -m "nota desta alteracao"```

**enviar alterações:**
```git push origin "nome da branch para atualizar"```


## Criando RDS
**RDS** *(Relational Database Service)* é o sistema de banco de dados da **AWS**
Acesse o RDS e crie um banco de dados

![selecionarDB](https://github.com/diocleciano/eclinux/assets/52802623/ea6c34b2-d2b7-4240-989e-47039610728b)

Selecione o ***MYSQL***

![criar rds](https://github.com/diocleciano/eclinux/assets/52802623/3c67a296-bd47-469d-8d88-eba11c388e85)

selecione o nivel gratuito

![gratuito](https://github.com/diocleciano/eclinux/assets/52802623/f3f953a4-16ad-4080-a686-d0eb4e803804)

coloque um nome e uma senha

![nomeSenha](https://github.com/diocleciano/eclinux/assets/52802623/526914f2-2376-43dd-aa88-14d73c43a0a4)

Espere o banco de dados ser criado para pegar essa informação **(Endpoint)**

![pegarEndpoint](https://github.com/diocleciano/eclinux/assets/52802623/ca48a504-adee-4bff-92e5-d11b61824e0b)


## Criando EFS
**EFS** *(Elastic File System)* é o sistema de compartilhamento de diretorios e arquivos da **AWS**
Selecione o EFS e crie um e dê um nome

![nomeEfs](https://github.com/diocleciano/eclinux/assets/52802623/dd4d3076-610d-432d-93cd-0c3dc83faf41)


Pegue o ID do EFS:

![idefs](https://github.com/diocleciano/eclinux/assets/52802623/6ba0577b-0430-4506-8009-1ad1aa3dc754)

***peque as seguintes informações para o arquvo .sh:***

*"id no efs" "/seu/diretório/designado/" nfs4 "options" 0 0*

**mount-target-DNS:** DNS do seu efs

**Exemplo:** fs-ndfcjwhedf928yr42uhf.efs.us-east-1.amazonaws.com:/

efs-mount-point: o diretorio de montagem

**Exemplo:** /home/ec2-user/efs/

options: as opções de montagem

**Exemplo:** nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport

Exemplo de como juntar as informações:

 ***fs-ndfcjwhedf928yr42uhf.efs.us-east-1.amazonaws.com:/ /home/ec2-user/efs/ nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 0 0***

# Criando instancias

Já criamos o ***EFS*** e o ***RDS*** configure uma instância com ***16GB*** e usando a ***imagem amazon linux 2*** e nao esqueça de ***habilitar o IPV4 automatico nela*** e use o arquivo .sh deste repositório. Ele cria o arquivo do **docker-compose.yml** comas informações do **banco de dados**, **cria um diretorio** e ja **monta o EFS**

```
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

# Criar diretório "main" na home do usuário EC2
mkdir /home/ec2-user/main

# Montar o EFS
echo "fs-0df0c24f03161fb64.efs.us-east-1.amazonaws.com:/ /home/ec2-user/main nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 0 0" >> /etc/fstab
mount -a

# Criar arquivo docker-compose.yml no diretório main
cat <<EOT > /home/ec2-user/main/docker-compose.yml
version: '3'
services:
  wordpress:
    image: wordpress:latest
    ports:
      - "80:80"
    environment:
      WORDPRESS_DB_HOST: endpoint
      WORDPRESS_DB_USER: admlog
      WORDPRESS_DB_PASSWORD: senha
      WORDPRESS_DB_NAME: nomedb
    volumes:
      - /home/ec2-user/main:/var/www/html
EOT

# Dar permissões adequadas para o arquivo docker-compose.yml
chown ec2-user:ec2-user /home/ec2-user/main/docker-compose.yml

# Executar docker-compose no diretório main
su - ec2-user -c "cd /home/ec2-user/main && docker-compose up -d"
```

# Conectar na instancia:

![conectarNaInstancia](https://github.com/diocleciano/eclinux/assets/52802623/91a9fae3-3f96-44fc-a94f-5e2d3eedf3ee)

Após conectar a sua instância verifique que ja está com o diretório criado e montado apenas suba p container com o comando ```docker-compose up -d```

 #"id no efs" "/seu/diretório/designado/" nfs4 "tal coisa" 0 0

***Caso você tenha problemas em dar um ```docker-compose up -d``` e apareça mensagens de falha execute os comandos abaixo:***

```sudo chown ec2-user main/```
```sudo usermod -aG docker $USER```
```newgrp docker```
```docker-compose up -d```


#Target para health check 



#guia para usuario usar o githyb durante a criação:
#verificar alterações:
git status
#adicionar todos os arquivos modificados(se for um especifico troque o "." pelo arquivo) :
git add .
#adicionar o commit:
git commit -m "nota desta alteracao"
#enviar alterações:
git push origin "nome da branch para atualizar"


# Crie um modelo da instncia 

![fazer-modelo-da-instancia](https://github.com/diocleciano/eclinux/assets/52802623/d69bc8b5-19db-4d87-b394-6158d6e608c5)

Configure ela **com a vpc mas sem subnet**, se você faz o estágio sugiro que coloque todas as tags de permição pois ela é um modelo. 

# Crie um Target Group

Coloque o local ```/wp-content/``` como target para o health check

![create-target-group](https://github.com/diocleciano/eclinux/assets/52802623/0fad5568-68e0-4ceb-a098-535c02b3c0c0)

- Agora  so precisamos criar o ***Load balancer*** e selecionar o ***target group***

![resumo-lb](https://github.com/diocleciano/eclinux/assets/52802623/b12a784a-0a13-4de3-941d-5114ffb9472c)

- Criar o ***auto scaling*** e selecionar o ***Load balancer***

![config-load-balancer](https://github.com/diocleciano/eclinux/assets/52802623/fd49494f-fa73-4f2e-8d34-fa95eee27782)


# Regra de segurança do RDS

![SGbancodedados](https://github.com/diocleciano/eclinux/assets/52802623/2316969b-b9e4-489e-bdac-07fde88d65d8)

# Regra de segurança das instâncias

![sgRegras e portas](https://github.com/diocleciano/eclinux/assets/52802623/6a2b9952-3c9c-4198-8887-53ef5c191f67)
