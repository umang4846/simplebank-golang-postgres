postgres :
	docker run --name postgres13 -p 5431:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d  postgres:13

createdb :
	 docker exec -it postgres13 createdb --username=root --owner=root simple_bank

dropdb :
	docker exec -it postgres13 dropdb simple_bank

migrateup :
	migrate -path db/migration -database "postgresql://root:secret@localhost:5431/simple_bank?sslmode=disable" -verbose up

migratedown :
	migrate -path db/migration -database "postgresql://root:secret@localhost:5431/simple_bank?sslmode=disable" -verbose down

sqlc :
	sqlc generate

dockersqlc :
	docker run --rm -v ${pwd}:/src -w /src kjconroy/sqlc generate

test :
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc dockersqlc test