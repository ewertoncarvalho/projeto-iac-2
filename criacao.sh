#!/bin/bash

# Criar Departamentos (Pastas)

mkdir -p /publico /adm /ven /sec

# Criar grupos

GRUPOS=("GRP_ADM" "GRP_VEN" "GRP_SEC")

# Loop para criar cada grupo
for GRUPO in "${GRUPOS[@]}"
do

    # Cria o grupo
    groupadd $GRUPO

done

# Criar usuários

USERS=("carlos" "maria" "joao" "debora" "sebastiana" "roberto" "josefina" "amanda" "rogerio")

# Loop para criar usuários
for USER in "${USERS[@]}"
do

    # Criar usuário e senha padrao e diretório HOME
    useradd -m -p $(openssl passwd -1 "Senha123") $USER

    # Adicionar permissao de usuarios a pasta publica
    chmod 777 /publico

    # Adicionar permissao aos grupos
    chmod 770 G_ADM G_VEN G_SEC

    # Adicionar usuários aos grupos
    if [[ $USER == "carlos" || $USER == "maria" || $USER == "joao" ]]; then
        usermod -aG GRP_ADM $USER
    elif [[ $USER == "debora" || $USER == "sebastiana" || $USER == "roberto" ]]; then
        usermod -aG GRP_VEN $USER
    elif [[ $USER == "josefina" || $USER == "amanda" || $USER == "rogerio" ]]; then
        usermod -aG GRP_SEC $USER
    fi

done

