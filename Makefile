all: patch-swagger-doc format

build-plugin:
	cd tools/protoc-gen-authzen-helpers && go build -o protoc-gen-authzen-helpers .

buf-gen: init-git-hooks build-plugin
	./buf.gen.yaml

patch-swagger-doc: buf-gen
	./scripts/update_swagger.sh docs/openapiv2/apidocs.swagger.json

format: buf-gen
	buf format -w

init-git-hooks:
	git config --local core.hooksPath .githooks/
