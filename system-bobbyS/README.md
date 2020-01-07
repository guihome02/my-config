## Installation de la machine

### 1. Mettre à jour la liste des paquets

```shell
sudo apt-get update
sudo apt-get upgrade
```

### 2. Mettre à jour les paquets à l'aide du "Gestionnaire de mises à jour" (Update Manager)

### 3. Générer une clé GPG

```shell
gpg --gen-key
> (1) RSA et RSA
> 2048
> 0
> o
> Guillaume Lebot
> aniki.taicho@gmail.com
> GitHub
> O
```

```shell
gpg --armor --export XXXXXXXX
```

Ajouter la clé publique GPG générée par la commande précédente dans [GitHub](https://github.com/settings/keys).

### 4. Installer Git

```shell
sudo apt-get install git
ssh-keygen -t rsa -b 4096 -C "aniki.taicho@gmail.com"
cat ~/.ssh/id_rsa.pub
```

### 5. Installer Google Chrome

```shell
echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y google-chrome-stable
```

### 5. Installer Ansible

[Suivre les instructions](http://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html?#latest-releases-via-apt-debian)

### 6. Cloner ce repository

```shell
cd ~
mkdir Workspace
cd Workspace
git clone git@github.com:fsevestre/system.git
```

### 7. Lancer le script d'installation de l'environnement de travail

```shell
cd ~/Workspace/system/setup
./setup.sh
```

### 8. Installer diff-so-fancy

```shell
sudo npm install -g diff-so-fancy
```

### 9. Installer Docker

[Suivre les instructions](https://docs.docker.com/install/linux/docker-ce/debian/#install-using-the-repository)

```shell
sudo usermod -aG docker fsevestre
sudo apt-get install docker-compose
```

### 10. Configurer Blackfire

[Récupérer les valeurs](https://blackfire.io/my/settings/credentials)

```shell
export BLACKFIRE_CLIENT_ID=XXX
export BLACKFIRE_CLIENT_TOKEN=XXX
export BLACKFIRE_SERVER_ID=XXX
export BLACKFIRE_SERVER_TOKEN=XXX
```

### 11. Lancer docker-compose

```shell
cd ~/Workspace/system/setup/roles/docker
docker-compose up -d --build
```

### 12. Autres

Configuration de l'horloge : `%A, %d %b %Y %H:%M:%S%p`

## Lancer le serveur

### 1. Se connecter au container Docker

```shell
docker-ssh CONTAINER_NAME
```

### 2. Démarrer le serveur

```shell
cd project/path
bin/console server:start 0.0.0.0:50000
```

## PhpStorm

### 1. Réinitialiser compte gratuit

```shell
cd ~/.PhpStorm[version]
rm config/eval/PhpStorm[version].evaluation.key
rm config/options/options.xml
cd ~/.java/.userPrefs/jetbrains
rm -rf phpstorm
```

## Blackfire

#### 1. Profiler un script PHP en ligne de commande

```shell
blackfire run php <file>.php
```
