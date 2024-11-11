# Redeems Challenge

## Sumário
  * [Descrição do projeto](#descrição-do-projeto)
  * [Desenvolvimento](#desenvolvimento)
  * [Como rodar a aplicação](#como-rodar-a-aplicação)
  * [Como rodar os testes](#como-rodar-os-testes)
  * [Documentação da API](#documentação-da-api)

## Descrição do projeto

<p align="justify"> API desenvolvida para o desafio técnico de backend em Ruby. O objetivo é criar uma API para gerenciar páginas de resgates, onde os usuários podem preencher seus dados para serem aprovados e, após a aprovação, receberem os itens relacionados ao resgate.</p>

## Desenvolvimento

### Premissas

- [x] O resgate obrigatoriamente deve estar associado a uma página de resgate.
- [x] Páginas de resgate podem (ou não) ter variações de tamanhos.
- [x] Páginas de resgate podem (ou não) ter perguntas extras.
- [x] Páginas de resgate podem ficar inacessíveis para novos resgates.
- [x] O mesmo usuário não pode realizar novos resgates antes que o resgate anterior seja aprovado ou reprovado.

### Solução

Com base nas premissas:

- [x] Estrutura de banco de dados adequada, com tabelas para páginas de resgates, resgates, opções de tamanho, perguntas e respostas.
- [x] Operações da API para criação e consulta de resgates.
- [x] Testes unitários e de integração para validar as funcionalidades.

### Estrutura do Banco de Dados

![image](https://github.com/user-attachments/assets/61d834b7-16e6-4cac-bc1b-0811d1ab5947)

## Como rodar a aplicação

No terminal, clone o projeto:

```
git clone git@github.com:thalis-freitas/redeems-challenge-ruby.git
```

Acesse a pasta do projeto:

```
cd redeems-challenge-ruby
```

Certifique-se de que o Docker esteja em execução em sua máquina e construa as imagens:

```
docker compose build
```

Suba o servidor:

```
docker compose up app
```

## Como rodar os testes

```
docker compose up test
```

## Documentação da API

Para acessar a documentação da API, abra seu navegador e vá para:

```
http://localhost:3000/api-docs
```

A documentação estará disponível no Swagger UI, onde você poderá explorar todos os endpoints da API, verificar as requisições, parâmetros e respostas esperadas.
