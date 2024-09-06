# Table of Contents

1. [English Version](#acm-monitoring-english-version)
   - [Project Structure](#project-structure)
   - [Main Files](#main-files)
   - [Modules](#modules)
   - [Functionalities](#functionalities)
   - [Project Execution](#project-execution)
2. [Versão Português](#acm-monitoring-versão-português)
   - [Estrutura do Projeto](#estrutura-do-projeto)
   - [Arquivos Principais](#arquivos-principais)
   - [Módulos](#módulos)
   - [Funcionalidades](#funcionalidades)
   - [Execução do Projeto](#execução-do-projeto)

---
# ACM Monitoring (English Version)

This repository contains a set of infrastructure resources defined using Terraform to monitor ACM (Amazon Certificate Manager) certificates and notify about certificates that are about to expire. It leverages AWS services like Lambda functions, EventBridge (formerly CloudWatch Events), and SNS (Amazon Simple Notification Service).

## Project Structure

```bash
.
├── ACM_Lambda_Function
│   ├── README.md
│   ├── backend.tf
│   ├── modules
│   │   ├── eventbridge
│   │   │   ├── eventbridge.tf
│   │   │   └── variables.tf
│   │   ├── iam
│   │   │   ├── output.tf
│   │   │   ├── role_eventbridge.tf
│   │   │   ├── role_get_acm_lambda.tf
│   │   │   ├── role_start_lambda.tf
│   │   │   └── variables.tf
│   │   ├── lambda
│   │   │   ├── lambda_coordinator.tf
│   │   │   ├── lambda_get_acm.tf
│   │   │   ├── output.tf
│   │   │   ├── provider.tf
│   │   │   ├── source_code
│   │   │   │   ├── coordinator.py
│   │   │   │   └── get_acm.py
│   │   │   └── variables.tf
│   │   └── sns
│   │       ├── topic.tf
│   │       └── variables.tf
│   ├── modules.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── terrascan.toml
│   ├── tfsec-config.json
│   └── variables.tf
└── README.md
```

## Main Files

- **backend.tf:** Terraform backend configuration, defining remote state storage.
- **modules.tf:** Declaration of the modules used in the project.
- **outputs.tf:** Definition of Terraform outputs to export useful information.
- **provider.tf:** Configuration of the Terraform provider and AWS provider.
- **terrascan.toml:** Configuration for the TerraScan static security analysis tool.
- **tfsec-config.json:** Configuration for the tfsec static security analysis tool.
- **variables.tf:** Declaration of Terraform variables used throughout the project.

## Modules

- **eventbridge:** Configures the EventBridge schedule to trigger the Lambda function periodically.
- **iam:** Manages the IAM roles and policies required for the Lambda functions.
- **lambda:** Defines the Lambda functions and their configurations.
- **sns:** Creates an SNS topic for notifications about expired certificates.

## Functionalities

- **coordinator.py:** A Lambda function that coordinates the execution of other Lambda functions to check ACM certificates and notify about those close to expiration.
- **get_acm.py:** A Lambda function that lists ACM certificates in different regions and checks if they are near expiration. It also attempts to automatically renew certificates close to expiration.

## Project Execution

1. Configure your AWS credentials.
2. Modify the `backend.tf` and `variables.tf` files as necessary.
3. Edit the `coordinator.py` and `get_acm.py` files as needed.
4. Run `terraform init` to initialize the project.
5. Run `terraform apply` to create the infrastructure.
6. After successful execution, the `coordinator` Lambda function will be triggered periodically to check ACM certificates.

Make sure to review and customize the settings as needed before applying changes.

---
# ACM Monitoring (Versão Português)

Este repositório contém um conjunto de recursos de infraestrutura definidos usando Terraform para monitorar os certificados ACM (Amazon Certificate Manager) e notificar sobre os certificados que estão prestes a expirar. Ele utiliza funções Lambda, EventBridge (anteriormente CloudWatch Events) e SNS (Amazon Simple Notification Service) na AWS.

## Estrutura do Projeto

```bash
.
├── ACM_Lambda_Function
│   ├── README.md
│   ├── backend.tf
│   ├── modules
│   │   ├── eventbridge
│   │   │   ├── eventbridge.tf
│   │   │   └── variables.tf
│   │   ├── iam
│   │   │   ├── output.tf
│   │   │   ├── role_eventbridge.tf
│   │   │   ├── role_get_acm_lambda.tf
│   │   │   ├── role_start_lambda.tf
│   │   │   └── variables.tf
│   │   ├── lambda
│   │   │   ├── lambda_coordinator.tf
│   │   │   ├── lambda_get_acm.tf
│   │   │   ├── output.tf
│   │   │   ├── provider.tf
│   │   │   ├── source_code
│   │   │   │   ├── coordinator.py
│   │   │   │   └── get_acm.py
│   │   │   └── variables.tf
│   │   └── sns
│   │       ├── topic.tf
│   │       └── variables.tf
│   ├── modules.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── terrascan.toml
│   ├── tfsec-config.json
│   └── variables.tf
└── README.md
```

## Arquivos Principais

- **backend.tf:** Configuração do backend do Terraform, definindo o armazenamento do estado remoto.
- **modules.tf:** Declaração dos módulos utilizados no projeto.
- **outputs.tf:** Definição de saídas do Terraform para exportar informações úteis.
- **provider.tf:** Configuração do provedor Terraform e do provedor AWS.
- **terrascan.toml:** Configurações para a ferramenta de análise estática de segurança TerraScan.
- **tfsec-config.json:** Configurações para a ferramenta de análise estática de segurança tfsec.
- **variables.tf:** Declaração de variáveis Terraform usadas em todo o projeto.

## Módulos

- **eventbridge:** Configura o agendamento no EventBridge para acionar a função Lambda periodicamente.
- **iam:** Gerencia as funções e políticas IAM necessárias para as funções Lambda.
- **lambda:** Define as funções Lambda e suas configurações.
- **sns:** Cria um tópico SNS para notificações sobre certificados expirados.

## Funcionalidades

- **coordinator.py:** Uma função Lambda que coordena a execução de outras funções Lambda para verificar certificados ACM e notificar sobre os que estão prestes a expirar.
- **get_acm.py:** Uma função Lambda que lista os certificados ACM em diferentes regiões e verifica se estão próximos da expiração. Também tenta renovar automaticamente os certificados próximos da expiração.

## Execução do Projeto

1. Configure suas credenciais AWS.
2. Altere os arquivos `backend.tf` e `variables.tf` conforme o necessário.
3. Edite os arquivos `coordinator.py` e `get_acm.py` conforme necessário.
4. Execute `terraform init` para inicializar o projeto.
5. Execute `terraform apply` para criar a infraestrutura.
6. Após a execução bem-sucedida, a função Lambda `coordinator` será acionada periodicamente para verificar os certificados ACM.

Certifique-se de revisar e personalizar as configurações conforme necessário antes de aplicar as alterações.