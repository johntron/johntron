## Data

Edit:
```
docker run -d \
    -p 5432:5432 \
    --name fitness-data \
    -e POSTGRES_PASSWORD=mysecretpassword \
    -v $PWD/data:/var/lib/postgresql/data \
    -v $PWD/sql:/var/lib/postgresql/sql \
    postgres:alpine
```

Backup:
```
docker exec -it fitness-data pg_dump \
    --host=localhost \
    --username=postgres \
    --password \
    --schema=public \
    --file /var/lib/postgresql/sql/dump.sql
```

Restore:
```
docker exec -it fitness-data psql \
    --user postgres \
    --password \
    --file /var/lib/postgresql/sql/dump.sql
```