all: build

build:
	@docker build --rm=false --tag=sameersbn/postgresql .

release: build
    @docker build --rm=false --tag=sameersbn/postgresql:$(shell cat VERSION) .