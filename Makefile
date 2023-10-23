export PROJECT_NAME = blog-devkblaz
export COMPOSE_PROJECT_NAME = ${PROJECT_NAME}-infra

check-project:
ifndef PROJECT_NAME
	$(error PROJECT_NAME is required)
endif


make build:
	docker-compose build

state-init: 
	docker-compose run --rm -w /code/remote-state infra sh -c " \
		rm -rf .terraform && \
		terraform init \
	"

state-init-upgrade: 
	docker-compose run --rm -w /code/remote-state infra sh -c " \
		rm -rf .terraform && \
		terraform init -upgrade \
	"

state-apply: 
	docker-compose run --rm -w /code/remote-state infra \
		terraform apply -var-file=../main.auto.tfvars -var-file=../backend.auto.tfvars

init: 
	docker-compose run --rm infra sh -c " \
		rm -rf .terraform && \
		terraform init -backend-config=backend.auto.tfvars \
	"

init-upgrade: 
	docker-compose run --rm infra sh -c " \
		rm -rf .terraform && \
		terraform init -backend-config=backend.auto.tfvars -upgrade \
	"

init-without-backend: 
	docker-compose run --rm infra sh -c " \
		rm -rf .terraform && \
		terraform init -backend=false \
	"

plan: 
	docker-compose run --rm infra terraform plan

apply: 
	docker-compose run --rm infra terraform apply

destroy: state-init init
	docker-compose run --rm infra terraform destroy

pull-state: check-project 
	docker-compose run --rm infra sh -c "terraform state pull > state.json"

fmt:
	docker-compose run --rm -w /code infra terraform fmt -diff -recursive

validate: 
	docker-compose run --rm -w /code infra terraform validate

get_bucket_name = $$(docker-compose run --rm -w /code/remote-state -T \
	infra terraform output -raw bucket_name)

shell: check-project 
	docker-compose run --rm infra sh
