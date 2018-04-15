# EquipEngine

# prepare enviroment
1. install ruby via rvm for example
2. install redis server
3. install postgres
4. install elasticksearch
5. create some subdomains at /etc/hosts , for ex.:
    127.0.0.1   a.localhost
    127.0.0.1   b.localhost

# install app

in root directory:

0. make settings for db in config/database.yml

1. $ bundle install

2. $ rake db:migrate

3. $ rake db:seed

# start app

1. $ foreman start

3. open 'server' side at browser localhost:4500
