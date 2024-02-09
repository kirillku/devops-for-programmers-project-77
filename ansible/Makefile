init:
	ansible-galaxy install -r requirements.yml

deploy:
	ansible-playbook --vault-password-file ../.vault_pass.txt -i inventory.ini playbook.yml --tags deploy

monitoring:
	ansible-playbook --vault-password-file ../.vault_pass.txt -i inventory.ini playbook.yml --tags monitoring

edit-vault-vars:
	ansible-vault edit group_vars/vault.yml --vault-password-file ../.vault_pass.txt