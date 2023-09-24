# eclinux
Linux e instâncias EC2(Amazon Web Services)

Este repositório será usado para práticas de atividades de DevOps

Atividade 1 servidor NFS:
O nfs se trata de uma tecnologia de host que compartilha um diretorio deixando os disponiveis na pela rede. Nesta atividade faço uma instância EC2 compartilhar um diretório onde ela armazena os logs de uma pagina do servidor apache e os conmpartilha com a maquina que montou o diretório compartilhado.
A maquina host apenas envia e a máquina cliente apenas recebe esses dados.

Atividade 2 docker, wordpress e load balancer:
Esta atividade se trata se fazer um ambiente em que o wordpress funcione em um container docker numa instancia EC2 com load balancewr e auto escaling. Tudo no free tier é claro.
*Nesta atividade usamos estes recursos da AWS:*
- VPC - Rede de internet da aws;
- RDS - Para banco de dados;
- EC2 - Criar instancias com linux;
- EFS - Sistema de compartilhamento de diretórios compatíveis apenas com imagens linux.
