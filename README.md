# Mysql Database

Mysql database installation using ansible

## Dependências
![Badge](https://img.shields.io/badge/ansible-2.9.10-blue)

## Suporte SO

- Ubuntu20
- Debian10
- Rocky8
- Centos8

# Como Usar!!!

## Crie o arquivo de inventário hosts 

## Variáveis

| Nome | Descrição | Default | 
|------|-----------|---------|
| database_name | Nome database | db01
| database_user | Nome user | user01 
| database_address | IP database | 127.0.0.1
| user_privileges | privilegios user | 127.0.0.1

## Exemplo de variáveis em /vars

mysql_databases:
  - name: "{{ database_name }}"
    login_password: "{{ mysql_root_pass }}"
    encoding: utf8
    collation: utf8_bin
mysql_users:
  - login_password: "{{ mysql_root_pass }}"
    name: "{{ database_user }}"
    password: "{{ mysql_user_pass.stdout }}"
    priv: "{{ database_name }}.*:ALL"

## Exemplo de playbook para instalação
```
---
- name: Install Database
  hosts: all
  become: true
  roles:
    - mysql
```
## Exemplo execute o playbook
``` 
ansible-playbook -i hosts playbook.yml"
```
## Licença
![Badge](https://img.shields.io/badge/license-GPLv3-green)
