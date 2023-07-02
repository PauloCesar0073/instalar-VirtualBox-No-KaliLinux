#!/usr/bin/bash

# Verifica se o script está sendo executado como root
if [[ $EUID -ne 0 ]]; then
    echo "Este script precisa ser executado como root."
    exit 1
fi

# Função para exibir o banner
show_banner() {
    echo "==============================="
    echo "    Instalação do VirtualBox   "
    echo "==============================="
    echo
}

# Exibe o banner
show_banner
sleep 2

echo "Adicionando o repositório do VirtualBox..."
echo -ne '###                     (10%)\r'
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian bullseye contrib" >> /etc/apt/sources.list
echo -ne '######                  (20%)\r'
sleep 2

echo "Baixando a chave GPG do repositório..."
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo gpg --dearmor -o /usr/share/keyrings/oracle-virtualbox-2016.gpg
echo -ne '#########               (40%)\r'
sleep 2

echo "Atualizando o sistema..."
sudo apt update -y
echo -ne '############            (60%)\r'
sleep 2

echo "Instalando o VirtualBox..."
sudo apt install virtualbox -y
echo -ne '###############         (70%)\r'
sleep 2

echo "Corrigindo dependências..."
sudo apt --fix-broken install
echo -ne '#################       (80%)\r'
sleep 2

echo "Instalando o VirtualBox novamente (caso necessário)..."
sudo apt install virtualbox -y
echo -ne '####################    (90%)\r'
sleep 2

echo "Limpando a tela e finalizando a instalação..."
clear
show_banner
echo "VirtualBox foi instalado com sucesso!"
sleep 2
