 4. Générer une clé GPG 
Cette clé GPG est utilisée pour signer les commits Git.

$ gpg --gen-key
> (1) RSA et RSA
> 2048
> 0
> o

Name : John DOE
E-mail : jdoe@profideo.com
Comment : Profideo - GitHub

Cela va générer l’identité suivante :
John DOE (Profideo - GitHub) <jdoe@profideo.com>

> O

$ BCF025FABCF025FA {KEY_ID}
# Remplacer {KEY_ID} par la clé retournée par la commande précédente (pub 2048R/98CAEB6C 2016-09-21, par exemple)
# Clé à garder dans un coin, on en aura besoin plus tard.

Ajouter la clé publique GPG générée par la commande précédente dans GitHub, partie “New GPG keys”.

Tip : changer la passphrase de la clef GPG 
(https://www.cyberciti.biz/faq/linux-unix-gpg-change-passphrase-command/)
$ gpg --edit-key {KEY_ID}
$ gpg> passwd
$ gpg> save


          5. Installer Git

Si ce n’est pas fait, fournir l’identifiant github au pôle exploitation pour être ajouté à l’organisation Profideo et obtenir des droits en lecture/écriture sur les dépôts.

$ sudo apt-get install git

# Crée une nouvelle clé SSH
$ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
NB: idéalement, on fournit une passphrase et on utilise un ssh-agent pour ne pas avoir à la taper à chaque utilisation (si c’est du chinois, pas de passphrase, ça marche, mais c’est tout de même moins sécurisé)


$ cat ~/.ssh/id_rsa.pub
Coller le résultat dans Github, partie “New SSH key”

          ### 6. Cloner le repository “exploitation”
$ cd ~
$ mkdir workspace
$ cd workspace
$ git clone git@github.com:Profideo/exploitation.git

/!\ En attendant validation finale, pour mint  19, il faut utiliser la branche spécifique mint19 pour l’installation du poste de travail.
        7. Installer ansible (marche avec une version python 2.7)
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt update
$ sudo apt-get install ansible 
8. Lancer le script d’installation de l’environnement de travail
$ cd ~/workspace/exploitation
$ 
  r

Répondre y aux différentes questions posées.
Actions du script :
Installation de paquets Linux utiles
Installation d’un IDE : PhpStorm ou Netbeans
Installation d’un navigateur web en plus de Firefox (installé par défaut) : Google chrome
Installation et configuration de Git : fichiers .gitconfig et .gitignore_global
C’est ici que tu as besoin de la clé GPG que tu as généré plus haut
Installation de subversion et de SmartSVN
Installation de Nginx, Docker, ...
Ajout d’alias ssh pour se connecter aux serveurs de développement (server-db, server-dev4, …) et aux containers Docker locaux et de recette
Amélioration du terminal 
Ajout de l’utilisateur courant aux groupes docker et www-data

/!\ La distribution vim SPF13 ne s’installe plus toute seule, il faut lancer l’installation manuellement
$ sh /tmp/spf13.sh
          9. Autoriser la clé SSH
{jdoe} est à remplacer par le nom d’utilisateur de votre email fourni par l’exploitation.
$ export U=”{jdoe}”
$ cp ~/.ssh/id_rsa.pub ~/workspace/exploitation/ansible/roles/createEnv/files/ssh/devs/id_rsa.pub.$U
$ cp ~/.ssh/id_rsa.pub ~/workspace/exploitation/ansible/roles/deploySSHPublicKeys/files/ssh_keys/id_rsa.pub.$U
$ cp ~/.ssh/id_rsa.pub ~/workspace/exploitation/ansible/roles/setupServices/files/ssh/devs/id_rsa.pub.$U

Enregistrer le contenu dans un nouveau fichier id_rsa.pub.{jdoe} dans les dossiers :
~/workspace/exploitation/ansible/roles/createEnv/files/ssh/devs/
~/workspace/exploitation/ansible/roles/deploySSHPublicKeys/files/ssh_keys
~/workspace/exploitation/ansible/roles/setupServices/files/ssh/devs/

$ cd ~/workspace/exploitation

Commit le changement :
$ git add .
$ git commit -m ‘Add {jdoe} SSH key’
$ git push

Redémarrer la machine
Afin de mettre à jour les droits de l’utilisateur et le network.

          12. Générer les alias
$ cd ~/workspace/exploitation
$ ./generateAliasesFromInventories.sh
$ source /home/$(whoami)/.zsh_recette_aliases

          13. Créer les containers Docker
$ cd ~/workspace/exploitation
$ ./setupServices.sh local
$ ./createEnv.sh local

