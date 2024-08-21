BINARY_NAME=hello-app

dep:
		go mod download
		go mod tidy
		go mod vendor

vet:
		go vet

build:
		GOARCH=arm64 GOOS=darwin go build -o ${BINARY_NAME}-darwin main.go
		# GOARCH=amd64 GOOS=linux go build -o ${BINARY_NAME}-linux main.go
		# GOARCH=amd64 GOOS=window go build -o ${BINARY_NAME}-windows main.go

test:
		go test ./...

test_coverage:
		go test ./... -coverprofile=coverage.out
		go tool cover -html=coverage.out -o coverage.html

lint:
		golangci-lint run --enable-all

run:
		./${BINARY_NAME}-darwin

clean:
		go clean
		rm -rf ${BINARY_NAME}-darwin
		rm -rf ${BINARY_NAME}-linux
		# rm -rf ${BINARY_NAME}-windows

build_run: dep vet build run

test_build: dep vet test_coverage build