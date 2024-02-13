init:
	$(MAKE) init -C terraform
	$(MAKE) init -C ansible

apply:
	$(MAKE) apply -C terraform

deploy:
	$(MAKE) deploy -C ansible

monitoring: 
	$(MAKE) monitoring -C ansible

destroy:
	$(MAKE) destroy -C terraform
