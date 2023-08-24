# Atividade sobre docker na AWS

***Proposta:***
 Criar um sistema de instancias EC2 com auto scaling e load balancer que disponibilizem uma aplicaçao de wordpress usando docker.

Recursos usados na AWS:
- **VPC** - Rede de internet da aws;
- **RDS** - Para banco de dados;
- **EC2** - Criar instancias com linux;
- **EFS** - Sistema de compartilhamento de diretórios compatíveis apenas com imagens linux.

> Vamos seguir os seguintes passos nesta ordem para criarmos tudo de forma rapida, como já fiz um passo a passo de criação de VPC anteriormente vou utilizar ela para esta também, ela esta com todo trafego de entrada liberado para o SG *(Security Group)* das instancias. 

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

Peque as seguintes informações do efs **(DNS)**



Pegue o id do EFS:

![idefs](https://github.com/diocleciano/eclinux/assets/52802623/6ba0577b-0430-4506-8009-1ad1aa3dc754)


conectar na instancia:

![conectarNaInstancia](https://github.com/diocleciano/eclinux/assets/52802623/91a9fae3-3f96-44fc-a94f-5e2d3eedf3ee)


criar docker compose:
![criar docker-compose](https://github.com/diocleciano/eclinux/assets/52802623/50a804b4-7284-43aa-bf03-5810f7cbe2fd)



![resumo-lb](https://github.com/diocleciano/eclinux/assets/52802623/b12a784a-0a13-4de3-941d-5114ffb9472c)
![fazer-modelo-da-instancia](https://github.com/diocleciano/eclinux/assets/52802623/06faa753-2bb9-43c7-bd48-ee50bead033a)
![create-target-group](https://github.com/diocleciano/eclinux/assets/52802623/0fad5568-68e0-4ceb-a098-535c02b3c0c0)
![config-load-balancer](https://github.com/diocleciano/eclinux/assets/52802623/fd49494f-fa73-4f2e-8d34-fa95eee27782)
![config1-modelo-execução](https://github.com/diocleciano/eclinux/assets/52802623/7f74446d-cbea-4bb9-becc-4055a4aec25f)
![vpcBancodeDados](https://github.com/diocleciano/eclinux/assets/52802623/8717a31a-8478-4e4c-a531-2a17bc2c93b6)
![volume](https://github.com/diocleciano/eclinux/assets/52802623/b04a4120-d798-46e3-b9f4-05ae695a654f)
![tipoDaInstancia](https://github.com/diocleciano/eclinux/assets/52802623/ef2425cf-a3df-4ebc-806e-ffecf6f474ce)
![tagsconfiguradas](https://github.com/diocleciano/eclinux/assets/52802623/3ba9c2ca-d85c-469f-a793-7bd0129f9e1a)
![tags](https://github.com/diocleciano/eclinux/assets/52802623/d66888e7-f507-4816-9d7c-b10f87396217)
![slecaoDeVPC](https://github.com/diocleciano/eclinux/assets/52802623/e5df7af0-4e66-4f6b-b0f7-61389370cf4c)
![sgRegras e portas](https://github.com/diocleciano/eclinux/assets/52802623/6a2b9952-3c9c-4198-8887-53ef5c191f67)
![SGconfig](https://github.com/diocleciano/eclinux/assets/52802623/bdad57b6-6bb6-4f5f-b4b3-a343877c5d35)
![SGbancodedados](https://github.com/diocleciano/eclinux/assets/52802623/2316969b-b9e4-489e-bdac-07fde88d65d8)
![SG](https://github.com/diocleciano/eclinux/assets/52802623/c35e297e-1cb5-457c-8471-6b0a03fab070)
![selecionarRegiao](https://github.com/diocleciano/eclinux/assets/52802623/23c47bee-355d-438d-8b7d-8c5ca4b26441)
![selecionarInstancia](https://github.com/diocleciano/eclinux/assets/52802623/7cd11f47-0119-473c-839e-23061c2cd03a)
![selecionarDB](https://github.com/diocleciano/eclinux/assets/52802623/af60cc78-ba27-450c-9252-9733665a6633)
![selecaoIP](https://github.com/diocleciano/eclinux/assets/52802623/f004dbfe-2a79-4b65-97d8-d52b72aac556)
![resumo-lb](https://github.com/diocleciano/eclinux/assets/52802623/797a9f70-fc1c-49f3-bac0-7b9034efd4dd)
![regraWordpress](https://github.com/diocleciano/eclinux/assets/52802623/ce509cf1-a692-4129-ab5d-e8a62a5d4ec4)
![imagem](https://github.com/diocleciano/eclinux/assets/52802623/04501da0-5759-49f1-8efc-e7fc86dff33d)
![fazer-modelo-da-instancia](https://github.com/diocleciano/eclinux/assets/52802623/d69bc8b5-19db-4d87-b394-6158d6e608c5)
![espera criar](https://github.com/diocleciano/eclinux/assets/52802623/51b628be-6afb-404a-872b-d4c24d2bce06)
![dnsDoEFS](https://github.com/diocleciano/eclinux/assets/52802623/478f6f10-caf2-40ea-9ac2-5e9b249eb147)
![criar rds](https://github.com/diocleciano/eclinux/assets/52802623/f510e846-d4e2-40bc-aae8-18c210d4e061)
![create-target-group](https://github.com/diocleciano/eclinux/assets/52802623/ff1c3bed-b311-4098-b294-22baf933c72f)
![config-load-balancer](https://github.com/diocleciano/eclinux/assets/52802623/8e1e99ea-949d-4aad-8c11-8cd27ee19963)
![config1-modelo-execução](https://github.com/diocleciano/eclinux/assets/52802623/6f8d33be-af69-4656-a682-82ae57a30af3)
![composeps](https://github.com/diocleciano/eclinux/assets/52802623/00656807-df64-43b2-9add-64276315ffe1)
![codigoSH](https://github.com/diocleciano/eclinux/assets/52802623/17507b1d-7db5-40eb-a268-c2edd00d804d)
![chave](https://github.com/diocleciano/eclinux/assets/52802623/2f26cdd8-cf8c-48f6-a412-0fb5600e12e0)
![Captura de tela_2023-08-19_16-38-55](https://github.com/diocleciano/eclinux/assets/52802623/3047a067-2944-4b1e-9c8b-e94c6c620dd6)
![botaopegarcoisadoEFS](https://github.com/diocleciano/eclinux/assets/52802623/80c5ab85-1a8e-46c8-b9e0-f9d870b431ff)
![botaoAcessoInstancia](https://github.com/diocleciano/eclinux/assets/52802623/809d935b-d127-4bc0-b580-af5b4ce64af8)
![boataoAlocarEnderecoIP](https://github.com/diocleciano/eclinux/assets/52802623/76a37ea6-715a-4446-8a03-3f3ced992dbc)
![associarenderecoIP](https://github.com/diocleciano/eclinux/assets/52802623/1b9be837-548d-4b7f-84c5-656d9c06e070)
![adicionarRegras](https://github.com/diocleciano/eclinux/assets/52802623/3465d871-04b3-4568-9ec2-2924b0035e7c)
