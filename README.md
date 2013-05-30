neo_beer
========

A POC Neo4j Application about Beer


Installation
----------------

    git clone git://github.com/maxdemarzi/neo_beer.git
    bundle install (run gem install bundler if you don't have bundler installed)
    rake neo4j:install
    unzip neobeer.zip into the neo4j/data/graph.db directory (create graph.db directory)
    rake neo4j:start
    foreman start

On Heroku
---------

    git clone git://github.com/maxdemarzi/neo_beer.git
    heroku apps:create neobeer
    heroku addons:add neo4j
    replace your database with the one in this repo (neobeer.zip)
    git push heroku master

See it running live at http://neobeer.heroku.com