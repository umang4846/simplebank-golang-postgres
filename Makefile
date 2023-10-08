postgres :
	docker run --name postgres13 -p 5431:5432 --network bank-network -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d  postgres:13

createdb :
	 docker exec -it postgres13 createdb --username=root --owner=root simple_bank

dropdb :
	docker exec -it postgres13 dropdb simple_bank

migrateup :
	migrate -path db/migration -database "postgresql://root:secret@localhost:5431/simple_bank?sslmode=disable" -verbose up

migrateup1 :
	migrate -path db/migration -database "postgresql://root:secret@localhost:5431/simple_bank?sslmode=disable" -verbose up 1

migratedown :
	migrate -path db/migration -database "postgresql://root:secret@localhost:5431/simple_bank?sslmode=disable" -verbose down

migratedown1 :
	migrate -path db/migration -database "postgresql://root:secret@localhost:5431/simple_bank?sslmode=disable" -verbose down 1
sqlc :
	sqlc generate

dockersqlc :
	docker run --rm -v ${pwd}:/src -w /src kjconroy/sqlc generate

test :
	go test -v -cover ./...

server :
	go run main.go

mock :
	mockgen -package mockdb -destination db/mock/store.go github.com/umang4846/simple_bank/db/sqlc Store
.PHONY: postgres createdb dropdb migrateup migratedown sqlc dockersqlc test server mock