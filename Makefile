postgres:
	docker run --name postgres-0 -e POSTGRES_USER=user -e POSTGRES_PASSWORD=password -d -p 5432:5432 postgres:16.2

createdb:
	docker exec -it postgres-0 createdb --username=user --owner=user simple_bank

dropdb:
	docker exec -it postgres-0 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://user:password@localhost:5432/simple_bank?sslmode=disable" -verbose up
	
migratedown:
	migrate -path db/migration -database "postgresql://user:password@localhost:5432/simple_bank?sslmode=disable" -verbose down

migratedownforce:
	migrate -path db/migration -database "postgresql://user:password@localhost:5432/simple_bank?sslmode=disable" -verbose force 1

sqlc:
	sqlc generate

test:
	go test -v -cover -short ./...

server:
	go run main.go

.PHONY: createdb dropdb postgres migrateup migratedown sqlc test server
