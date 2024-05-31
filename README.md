# Mysql Database

Mysql database installation using ansible

## Requirements

![Badge](https://img.shields.io/badge/ansible-2.16.6-blue)

## Suport SO

- Ubuntu20
- Debian10
- Rocky8
- Centos8

## Variables

| Name | Description | Default | 
|------|-----------|---------|
| mysql_databases | Databases | []
| mysql_users | User databases | [] 
| mysql_root_username | User root | root
| mysql_root_pass | Pass root | Tg0z64OVddNzFwNA==

*Inside vars.yml:*

```
mysql_root_pass: yQE9ob2yqR4
mysql_databases:
  - name: "db"
    encoding: utf8
    collation: utf8_bin
mysql_users:
  - name: "dbuser"
    host: "%"
    password: "yQE9ob2yqR4=xxtttrr5"
    priv: "db.*:ALL"
```

## Example playbook instalation
```
---
- name: Install Database
  hosts: all
  become: true
  vars_files:
    - vars.yml
  roles:
    - mysql
```
## Example execute the playbook

```bash 
ansible-playbook -i hosts playbook.yml --extra-vars "@vars.yml"
```

## Example inventory

```bash
[all]
127.0.0.1 ansible_ssh_private_key_file=PATH/private_key 

[all:vars]
ansible_user=username
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```

- Example connect

```bash
mysql -u dbuser -h 172.16.3.10 -p db
```

## Licença
![Badge](https://img.shields.io/badge/license-GPLv3-green)
