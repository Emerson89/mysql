# Mysql Database

**ansible for installation, users creation, databases, permissions, dump and restore database MySQL** 

## Requirements

- ansible-2.16.6
- PyMySQL >= 1.1.1
- community.mysql

## Suport SO

- Ubuntu20
- Debian10
- Rocky8
- Centos8

## Variables

| Name | Description | Default | 
|------|-----------|---------|
| mysql_databases | Databases/Dump/Restore | []
| mysql_users | User databases | [] 
| mysql_root_username | User root | root
| install_mysql | Install mysql in VM | false
| create_database_dump_restore | Enabled create database or dump or restore database | false
| create_users_mysql | Enabled create users only remote use | false

## Pass user root mysql

When installing mysql in VM is generated a password for the root user of mysql and saved in the root directory in file called *passwordfile*

#
## Example playbook for mysql installation on VM

```yaml
---
- name: Install Database
  hosts: all
  become: true
  roles:
    - mysql
```

*Inside vars.yml:*

```yaml
install_mysql: true

mysql_databases:
  - name: "db"
    encoding: utf8
    collation: utf8_bin
  - name: 
      - "db2"
      - "db3"
    encoding: utf8
    collation: utf8_bin
          
mysql_users:
  - name: "dbuser"
    host: "%"
    password: "my-secret-pw"
    priv: "*.*:ALL,GRANT"
  - name: "dbuser2"
    host: "%"
    password: "my-secret-pw"
    priv:
      'db1.*': 'ALL,GRANT'
      'db2.*': 'ALL,GRANT'
```

```bash 
ansible-playbook -i inventory playbook.yml --extra-vars "@vars.yml"
```

## Example inventory

```bash
[all]
127.0.0.1 ansible_ssh_private_key_file=PATH/private_key 

[all:vars]
ansible_user=username
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```

## Example execute the playbook

```bash 
ansible-playbook -i hosts playbook.yml --extra-vars "@vars.yml"
```
#
## Example of playbook user creation, databases, dump, restore or privilege change

```yaml
---
- name: MySQL tasks
  hosts: localhost
  connection: local
  roles:
    - mysql
```

*Inside vars.yml:*

```yaml
install_mysql: false
create_database_dump_restore: true
create_users_mysql: true

mysql_databases:
  ## Create Databases
  - name: "db"
    encoding: utf8
    collation: utf8_bin
    login_host: 172.16.3.10
    login_user: dbuser
    login_password: my-secret-pw
  - name: 
      - "db2"
      - "db3"
    encoding: utf8
    collation: utf8_bin
    login_host: 172.16.3.10
    login_user: dbuser
    login_password: my-secret-pw 
  ## Delete database
  - name: 
      - "db2"
      - "db3"
    state: absent
    login_host: 172.16.3.10
    login_user: dbuser
    login_password: my-secret-pw
     
  ## Create Dump  
  - name: "db"
    target: dump.sql
    state: dump
    login_host: 172.16.3.10
    login_user: dbuser
    login_password: my-secret-pw 
  - name: "db"
    target: dump.sql
    state: dump
    single_transaction: true
    skip_lock_tables: false
    login_host: 172.16.3.10
    login_user: dbuser
    login_password: my-secret-pw   
  - name: "db"
    target: dump.sql
    state: dump
    login_host: 172.16.3.10
    login_user: dbuser
    login_password: my-secret-pw 
    ignore_tables:   
      - "db.users"
      - "db.store"
  
  ## Dump all databases --skip
  - name: "all"
    target: all.sql ## Uncompressed SQL files (.sql) as well as bzip2 (.bz2), gzip (.gz) and xz (Added in 2.0) compressed files are supported.
    state: dump
    force: true
    login_host: 172.16.3.10
    login_user: dbuser
    login_password: my-secret-pw
    dump_extra_args: "--skip-triggers --set-gtid-purged=OFF"  
  
  ## Restore
  - name: "db2"
    target: dump.sql ## Uncompressed SQL files (.sql) as well as bzip2 (.bz2), gzip (.gz) and xz (Added in 2.0) compressed files are supported.
    state: import
    login_host: 172.16.3.10
    login_user: dbuser
    login_password: my-secret-pw
  
  ## Import dump.sql with specific latin1 encoding
  - name: "all"
    target: all.sql ## Uncompressed SQL files (.sql) as well as bzip2 (.bz2), gzip (.gz) and xz (Added in 2.0) compressed files are supported.
    state: import
    encoding: latin1
    login_host: 172.16.3.10
    login_user: dbuser
    login_password: my-secret-pw

## Create Users
mysql_users:
  - name: "dbuser"
    host: "%"
    password: "my-secret-pw"
    priv: "*.*:ALL,GRANT"
    login_host: 172.16.3.10
    login_user: dbuser
    login_password: my-secret-pw
  - name: "dbuser2"
    host: "%"
    password: "my-secret-pw"
    priv:
      'db1.*': 'ALL,GRANT'
      'db2.*': 'ALL,GRANT'
    login_host: 172.16.3.10
    login_user: dbuser
    login_password: my-secret-pw 
  
  ## Remove Users
  - name: "dbuser"
    host: "%"
    password: "my-secret-pw"
    state: absent
    login_host: 172.16.3.10
    login_user: dbuser
    login_password: my-secret-pw     
```

## Example execute the playbook

```bash 
ansible-playbook playbook.yml --extra-vars "@vars.yml"
```

## Licença
![Badge](https://img.shields.io/badge/license-GPLv3-green)
