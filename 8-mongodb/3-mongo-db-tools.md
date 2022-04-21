# Mongo DB tools


## Importing data

```sh
mongoimport --db picnic --collection restaurants --drop --file primer-dataset.json

mongoimport --db picnic --collection movies --drop --file movies.json

mongoimport --db picnic --collection restaurants_big --drop --file restaurants_big.json
```
- Options:
  - `--port`: add data to a specific port
