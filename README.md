# bornesElec
Pour lancer le projet :
1. Build le projet 


## Build Sur Docker en 1 commande (Recommandé) : 
```
docker-compose up --build
```

Consultez le projet sur : 
- [myPhpAdmin](http://localhost:9001) sur http://localhost:9001

- [App](http://localhost:9000) sur http://localhost:9000

## Sur linux 
```bash
git clone https://github.com/slimane-msb/bornesElec.git

mv bornesElec www/var/html 

cd  www/var/html/bornesElec

sudo apt-get update
sudo apt-get install mysql-client

sudo mysql_secure_installation


mysql -u root -p "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';"

mysql -u root -proot -e "CREATE DATABASE BORNES;"


mysql -u root -proot BORNES < ./data/init.sql

```

Consultez le projet sur : 
- [myPhpAdmin](http://localhost/phpmyadmin/) sur http://localhost/phpmyadmin/
- [App](http://localhost/bornesElec/src) sur http://localhost/bornesElec/src