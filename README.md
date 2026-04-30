#  Infraestrutura AWS Modular com Terraform

Este projeto demonstra a criação de uma infraestrutura na AWS utilizando **Terraform com arquitetura modular**, com foco em **organização, reutilização e comunicação entre módulos através de outputs**.

---

##  Arquitetura

A infraestrutura é composta por:

* VPC
* Subnets públicas
* Internet Gateway
* Security Groups
* EC2
* S3 (armazenamento)

Fluxo:

```id="k2m8zp"
Internet
   ↓
EC2 (instância provisionada via Terraform)
   ↓
S3 (armazenamento de objetos)
```

---

##  Objetivo do Projeto

Demonstrar na prática:

* Infraestrutura como Código (IaC)
* Modularização com Terraform
* Uso de outputs para integração entre módulos
* Provisionamento automatizado na AWS
* Criação de recursos interdependentes (ex: EC2 + S3)

---

##  Tecnologias Utilizadas

* Terraform
* AWS (EC2, VPC, Subnets, S3, Security Groups)
* Linux (Amazon Linux)
* GitHub Actions (CI/CD)

---

##  Estrutura do Projeto

```id="r6y2xp"
.
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── vpc/
│   ├── ec2/
│   └── s3/
```

---

##  Uso de Outputs (Ponto principal do projeto)

Os módulos se comunicam através de outputs, garantindo baixo acoplamento e alta reutilização.

---

###  Exemplo 1 — VPC → EC2

Módulo VPC exportando subnets:

```hcl id="p4z9lx"
output "public_subnets" {
  value = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]
}
```

Consumido no módulo EC2:

```hcl id="q1x7nv"
subnet_id = module.vpc.public_subnets[0]
```

---

###  Exemplo 2 — S3 usando outputs

O bucket S3 pode ser criado utilizando informações vindas de outros módulos ou do root.

Exemplo:

```hcl id="j3w8ty"
resource "aws_s3_bucket" "this" {
  bucket = "${var.project_name}-bucket"
}
```

E exportando:

```hcl id="b9m2qe"
output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}
```

Esse output pode ser reutilizado por outros módulos (ex: EC2, aplicações, scripts).

---

##  Como Executar

### 1. Clonar o repositório

```bash id="n7d2fs"
git clone https://github.com/seu-usuario/seu-repo.git
cd seu-repo
```

---

### 2. Inicializar o Terraform

```bash id="y8p3qa"
terraform init
```

---

### 3. Planejar

```bash id="c5m1zr"
terraform plan
```

---

### 4. Aplicar

```bash id="u2x9lk"
terraform apply
```

---

##  Outputs do Projeto

Exemplos de outputs disponíveis:

* ID da VPC
* IDs das subnets públicas
* IP público da EC2
* Nome do bucket S3

---

##  Segurança

* Security Groups controlam acesso à EC2
* Apenas portas necessárias são expostas
* Recursos isolados dentro da VPC
* Bucket S3 pode ser configurado com políticas restritas

---

##  Conceitos Aplicados

* Modularização no Terraform
* Separação de responsabilidades (rede, compute, storage)
* Comunicação entre módulos via outputs
* Infraestrutura declarativa e reutilizável
* Encadeamento de recursos

---

##  Observações

* Este projeto não inclui banco de dados
* Foco principal é estrutura modular e integração entre recursos
* Pode ser utilizado como base para aplicações mais complexas

---

##  Melhorias Futuras

* Integração do S3 com aplicações (upload/download)
* Versionamento do bucket
* Políticas IAM mais refinadas
* Adição de banco de dados (RDS)
* Load Balancer e Auto Scaling

---

##  Autor

Rafael Ferreira Neves

---

##  Conclusão

Este projeto demonstra a criação de uma infraestrutura AWS modular utilizando Terraform, destacando o uso de outputs para integração entre módulos e a criação de recursos interdependentes como VPC e S3.

---
