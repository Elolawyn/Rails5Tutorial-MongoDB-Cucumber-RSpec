# Tutorial de Ruby on Rails 5

Aplicación resultante del [Tutorial de Ruby on Rails](http://www.railstutorial.org/) de [Michael Hartl](http://www.michaelhartl.com/) usando MongoDB, Rspec y Cucumber.

<div id='index'/>
## Índice

1. [Entorno](#seccion01)
2. [Instalación](#seccion02)
3. [Ejecución](#seccion03)

<div id='seccion01'/>
## Entorno

[Volver al índice](#index)

1. Ruby 2.3.3
2. Ruby on Rails 5.0.1
3. Ubuntu 16.04.1 LTS
4. MongoDB 3.4
5. Rspec
6. Cucumber
7. Robomongo 0.9.0 (Opcional)

<div id='seccion02'/>
## Instalación

[Volver al índice](#index)

Para instalar ruby se utilizará **rbenv** que permitirá gestionar distintas versiones de ruby y utilizar la más conveniente. Ejecutar:

```bash
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
cd
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL
rbenv install 2.3.3
rbenv global 2.3.3
ruby -v
gem install bundler
rbenv rehash
gem install rails -v 5.0.1
rbenv rehash
```

### Instalar mongodb

Ejecutar:

```bash
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo service mongod start
```

### Instalar Robomongo (opcional)

1. Acceder a su página web y descargar la última versión para Linux.
2. Extraer en cualquier lugar y ejecutar.

<div id='seccion03'/>
## Ejecución

Configurar bases de datos en **config/mongoid.yml**. Ejecutar:

```bash
bundle install
rake db:seed
bundle exec rspec
bundle exec cucumber
rails s
```