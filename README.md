# ☁️ Cloud Infrastructure Provisioning (IaC)

Este repositório contém o código de **Infraestrutura como Código (IaC)** responsável por provisionar a fundação de rede e computação para um cluster Kubernetes gerenciável na Oracle Cloud Infrastructure (OCI). 

O foco deste módulo é criar uma infraestrutura base segura, escalável e imutável, demonstrando habilidades avançadas de arquitetura Cloud e redes.

## 🎯 Visão Executiva

A previsibilidade da infraestrutura é tão importante quanto a aplicação em si. Utilizando **Terraform**, este projeto elimina configurações manuais na nuvem e garante que o ambiente possa ser recriado, auditado e versionado de forma determinística e idempotente.

A infraestrutura foi desenhada para suportar workloads distribuídos, preparando o terreno (Rede, Computação e Segurança) para a posterior instalação do Kubernetes.

## 🏗️ Arquitetura de Nuvem (OCI)

A escolha da OCI como provedor demonstra flexibilidade e capacidade de adaptação além do ecossistema AWS/GCP, lidando com conceitos avançados de rede virtual e segurança.

| Recurso | Detalhes Técnicos e Propósito |
| :--- | :--- |
| **Computação (Compute Instances)** | Nós baseados na arquitetura AMD x86_64 (VM.Standard.E5.Flex). Dimensionados para isolar o Control Plane (Master) da camada de execução (Workers). |
| **Redes Virtuais (VCN & Subnets)** | Criação de uma Virtual Cloud Network dedicada, isolando o tráfego do cluster de outras aplicações e garantindo roteamento eficiente. |
| **Segurança (Security Lists)** | Firewall a nível de nuvem. Regras estritas foram mapeadas e aplicadas via código para permitir apenas o tráfego essencial: API do K8s (6443), comunicação de nós (10250) e tráfego CNI. |

## 🧠 Maturidade de Engenharia e Decisões

* **Separação de Camadas:** Este repositório foca 100% na criação do hardware virtual e rede. A instalação de softwares foi propositalmente delegada para ferramentas de Config Management (Ansible), evitando o uso de `user_data` complexos e difíceis de debugar, garantindo uma arquitetura limpa.
* **Saídas Dinâmicas (Outputs):** O código foi programado para exportar dinamicamente os IPs públicos e privados provisionados, alimentando automaticamente os inventários das esteiras de configuração subsequentes.
* **Segurança por Padrão (Security-First):** As portas não são abertas de forma irrestrita. O Terraform mapeia os requisitos exatos da CNCF para a comunicação do `kubeadm` e `kubelet`.