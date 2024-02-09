init:
	(cd terraform; make init)
	(cd ansible; make init)

apply:
	(cd terraform; make apply)

deploy:
	(cd ansible; make deploy)

monitoring: 
	(cd ansible; make monitoring)
