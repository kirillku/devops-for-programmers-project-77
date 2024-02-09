### Hexlet tests and linter status:

[![Actions Status](https://github.com/kirillku/devops-for-programmers-project-77/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/kirillku/devops-for-programmers-project-77/actions)

[![Upmon Status](https://www.upmon.com/badge/9e03cf2f-3078-4000-9924-ff6089/g-TPx3K1-2.svg)](https://www.upmon.com/projects/42a58075-c6a8-4574-8014-5e6eaa18d890/checks/)

DEMO: [kubryakov.online](http://kubryakov.online/)

---

### Getting started

1. Add `.vault_pass.txt` file to root folder

2. Install ansible and terraform dependencies

```bash
make init
```

3. Create nesessary assets in DO using terraform

```bash
make apply
```

4. Deploy readmine to created servers

```bash
make deploy
```

5. Add monitoring

```bash
make monitoring
```
