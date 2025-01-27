
---
<h1 align="center">
  🚀 Invite Manager 🚀
</h1>
<br>



Esse projeto foi desenvolvido com as seguintes tecnologias:

- [Ruby](https://www.ruby-lang.org/pt/)
- [PostgreSql](https://www.postgresql.org/)
- [Docker](https://www.docker.com/)

<div style="display: inline_block"><br>
  <img align="center" alt="Gui-Ruby" height="30" width="40" src="https://raw.githubusercontent.com/devicons/devicon/master/icons/ruby/ruby-original.svg">
  <img align="center" alt="Docker" height="30" width="40" src="https://raw.githubusercontent.com/devicons/devicon/master/icons/docker/docker-original.svg">
</div>

-----

# 💻 Projeto

Este projeto é uma aplicação Ruby on Rails desenvolvida para realizar o gerenciamento de Empresas, Convites e Administradores. 

<br>

#  💻 Passos para montar ambiente local
* Entrar na pasta do Projeto, e rodar `make up` no terminal.
* Após abri outro bash e rodar
    * Para criar o banco e rodar as migrations: `make setup` do ambiente de development.
    * Para criar o banco e rodar as migrations: `make setup_test` do ambiente de test. 
* Para rodar os testes funcionais podemos rodar: `make test` em outra aba do terminal.

Obs. Demais funcionalidades verificar o `Makefile` 

<br>

#  💻 Tela de Login

<br>
Foi criada a tela de login, possibilitando informar o e-mail e senha para realizar o login na aplicação
  * Todas os acessos as demais rotas da aplicação são acessadas apenas após o login.
<br>

![alt text](https://github.com/GUIFRE88/invite_manager/blob/main/prints/login.png)

<br>

#  💻 Tela de Cadastro

<br>
Foi criada a tela de cadastro para que seja criado o Administrado.
  * A criação de novos administrados para a aplicação, será feita nessa tela. 
<br>

![alt text](https://github.com/GUIFRE88/invite_manager/blob/main/prints/signup.png)

<br>

#  💻 Listagem de Administradores

<br>
Possuímos a listagem de todos os administradores.
  * Será possivel editar, excluir, relacionar convites e visualizar os convites relacionados ao administrador.
<br>

![alt text](https://github.com/GUIFRE88/invite_manager/blob/main/prints/listadm.png)

<br>

## Convites relacionados ao Administrador

<br>

![alt text](https://github.com/GUIFRE88/invite_manager/blob/main/prints/invites-to-admin.png)

<br>

## Tela para relacionar convites ao Administrador

<br>

![alt text](https://github.com/GUIFRE88/invite_manager/blob/main/prints/relatives-invites-to-admin.png)

Obs. Caso um convite seja relacionado a um Administrador ele não ficará mais visivel nessa tela, porém o convite poderá ser visto por outro administrador.

<br>

#  💻 Listagem de Empresas

<br>
Possuímos a listagem de todas as empresa.
  * Será possivel editar, criar, excluir, visualizar e relacionar convites para uma determinada empresa.
<br>

![alt text](https://github.com/GUIFRE88/invite_manager/blob/main/prints/companies.png)


<br>

#  💻 Relacionar convites a uma empresa

<br>
Nessa tela será possível relacionar convites ao uma empresa.
  * Após a seleção, ficará marcado os convites relacionados.
  * Caso seja desmarcado, o mesmo quebrará a relação com a empresa.
  * Apenas convites relacionados a uma empresa poderão ser atrelados um Administrador. 
<br>

![alt text](https://github.com/GUIFRE88/invite_manager/blob/main/prints/relatives-invites.png)

<br>


#  💻 Visualizar convites de uma empresa

<br>
Ao ir em "Show" e verificar os dados da empresa, também será possível verificar todos os convites atrelados a mesma. 
<br>

![alt text](https://github.com/GUIFRE88/invite_manager/blob/main/prints/showcompanies.png)

<br>



#  💻 Testes da aplicação com Rspec
<br>
Podemos ver que temos um total de 122 testes feitos com Rspec.
<br>

![alt text](https://github.com/GUIFRE88/invite_manager/blob/main/prints/ccoverage1.png)

<br>
Possuíndo um total de 99,41% de cobertura total de testes. 
<br>

![alt text](https://github.com/GUIFRE88/invite_manager/blob/main/prints/coverrage2.png)


<br>

---

# 💻 Rspec
Implementado testes com Rspec em cada projeto individualmente, por favor verifique a pasta /spec de cada projeto.


<br>

#  💻 Melhorias no projeto

Todo projeto oferece desafios e melhorias, creio que as melhorias seriam:


<br>

# 💻 Contribuição
Sinta-se à vontade para contribuir com melhorias ou correções! Para isso, faça um fork do repositório, crie uma branch com suas alterações e envie um pull request.

<br>

# 💻 Licença
Este projeto está licenciado sob a MIT License.


----
