# rails-peeringdb

Rails models to read [PeeringDB archives](https://www.caida.org/catalog/datasets/peeringdb/), intended to call `rails console` and `rails runner`.

No GUI. Not affiliated with [PeeringDB](https://www.peeringdb.com/).


## What's this project for?

CAIDA takes daily snapshots of [PeeringDB](https://www.peeringdb.com/) historic data and publishes [here](https://www.caida.org/catalog/datasets/peeringdb/).
Those archives are valuable but not easy to read because:

1. sqlite files of PeeringDB v1 (Jul 2010 through Mar 2016) - The app is not published 
2. sqlite files of PeeringDB v2 (Mar 2016 through Mar 2018) - Django app is available
3. API response dumps in JSON format of PeeringDB v2 (since Mar 2018 onward) - Django app cannot read

[Official PeerinDB app](https://github.com/peeringdb/django-peeringdb) can read only 2.

This project is intended to read those historic data in a programmatic way.


## How to use

### 1. sqlite files of PeeringDB v1 (Jul 2010 through Mar 2016)

```shell
$ git switch peeringdb-v1
$ bundle install

# Download any sqlite file of v1 as db/development.sqlite3, then

$ rails console
# or
$ rails runner your_code.rb
```

### 2. sqlite files of PeeringDB v2 (Mar 2016 through Mar 2018)

```shell
$ git switch peeringdb-v2
$ bundle install

# Download any sqlite file of v2 as db/development.sqlite3, then

$ rails console
# or
$ rails runner your_code.rb
```


### 3. API response dumps in JSON format of PeeringDB v2 (since Mar 2018 onward)

```shell
$ git switch peeringdb-v2
$ bundle install

$ rm db/development.sqlite3  # Only if you have
$ sqlite3 db/development.sqlite3 < db/598a658.sql

# Download any json file of v2 as archive.json for example, then

$ rails runner script/load.rb archive.json
```


## ER Diagram

### v1

![v1 ERD](https://raw.githubusercontent.com/wiki/codeout/rails-peeringdb/images/erd-v1.png)

### v2

![v2 ERD](https://raw.githubusercontent.com/wiki/codeout/rails-peeringdb/images/erd-v2.png)

## Copyright and License

Copyright (c) 2022 Shintaro Kojima. Code released under the MIT license.