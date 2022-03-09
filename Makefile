SHELL=/bin/bash

build-subgraph:
	cd valist-subgraph && lerna bootstrap && lerna run codegen && lerna run build

deploy-subgraph: build-subgraph
	cd valist-subgraph && lerna run deploy:ganache

build-contracts:
	cd valist-contracts && npm install && npm run build

deploy-contracts: build-contracts
	cd valist-contracts && npm run deploy:ganache

build-js:
	cd valist-js && lerna bootstrap && lerna run build

dev-js:
	cd valist-js && lerna bootstrap && lerna run dev --parallel

up:
	docker-compose up

down:
	docker-compose down

dev:
	$(MAKE) -j 2 up dev-js

build: build-subgraph build-contracts build-js

deploy: deploy-contracts deploy-subgraph