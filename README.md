# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


sudo docker pull docker.elastic.co/elasticsearch/elasticsearch:7.17.28

sudo docker run -p 9500:9200 -p 9600:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.17.28



sudo -u postgres createuser -s dev -p 5433
sudo -u postgres psql -p 5433


\password dev

qwerty
qwerty