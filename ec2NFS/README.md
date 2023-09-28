# projeto ec2NFS, linux e instancias ec2
## passo 1: criar chave .pub
No seu terminal de o comando ```ssh-keygen -t rsa -b 2048 -f ~/.ssh/minhachave``` para criar uma chave ssh publica para usar na criação e acesso da instancia na aws
***agora é so adicionar a chave a AWS***
## passo 2: Configurar a maquina EC2 servidor (onde fica o apache)
***instalar apache (httpd)***
```sudo yum install httpd``` instala o apache
```sudo systemctl start httpd``` liga o apache
```sudo systemctl enable httpd``` deixa ele ligado mesmo se a maquina reinicar
### 2 Este codigo deve ficar no arquivo exports em "/etc/exports" para enviar via nfs para o cliente
```
/mnt/diocleciano "IP_da_Instancia_Pagina"(rw,sync,no_root_squash)
```
### 3 conteudo do registro_logs.sh
***crie o arquivo no diretorio /root/***
```
#!/bin/bash
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
echo "Registro de logs em $TIMESTAMP" >> /var/log/httpd/diocleciano/access_log
```
***para o arquivo .sh funcionar corretamente tornando o executavél***
```
chmod +x /root/registro_logs.sh
```
### 4 criar diretorio
sudo mkdir /var/log/httpd/diocleciano
### 4 permissao de diretorio
sudo chmod -R 755 /var/log/httpd/diocleciano
sudo chown -R apache:apache /var/log/httpd/diocleciano

### configurar crontab
***comando*** ```sudo crontab -e``` ***e adicionar a ele*** ```*/5 * * * * /root/registro_logs.sh```
# configurar o cliente
***baixar o nfs***
sudo yum install nfs-utils
***criar diretorio para receber***
sudo mkdir /mnt/diocleciano
***montaro nfs***
**abra o arquivo** ```sudo vim /etc/fstab``` **e coloque** ```IP_do_Servidor:/var/log/httpd/diocleciano /mnt/diocleciano nfs defaults 0 0``` **de o comando para montar** ```sudo mount -a```
Procure o diretorio montado com ```df -h```
