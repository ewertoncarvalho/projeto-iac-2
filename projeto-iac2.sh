#!/bin/bash

# # **Verifica se o script é executado como root**

if [[ $(id -u) -ne 0 ]]; then
echo "O script deve ser executado como root." >&2
exit 1
fi

# # **Atualiza o servidor**

apt-get update && apt-get upgrade -y

# # **Verifica se o apache2 está instalado e, se não, instala**

if ! command -v apache2 >/dev/null; then
apt-get install apache2 -y
fi

# # **Verifica se o unzip está instalado e, se não, instala**

if ! command -v unzip >/dev/null; then
apt-get install unzip -y
fi

# # **Muda para o diretório /tmp**

cd /tmp

# # **Baixa o arquivo zip do site diretamente em /tmp**

if ! wget -qO linux-site-dio-main.zip "https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip"; then

echo "Falha ao baixar o arquivo do site." >&2
exit 1
fi

# # **Extrai o conteúdo do arquivo zip**

if ! unzip -q linux-site-dio-main.zip; then
echo "Falha ao extrair o conteúdo do arquivo zip." >&2
exit 1
fi

# # **Move o conteúdo extraído para o diretório do servidor web**

if ! cp -R linux-site-dio-main/* /var/www/html/; then
echo "Falha ao copiar o conteúdo para o diretório do servidor web." >&2
exit 1
fi

echo "O site foi instalado com sucesso."
echo "Para acessá-lo, abra um navegador e digite o endereço IP do servidor ou o nome do domínio seguido por '/index.html'."
