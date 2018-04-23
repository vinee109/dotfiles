include sync.mk

.PHONY: vscode
vscode:
	bash vscode/install.sh
	cp ./vscode/settings.json $(HOME)/Library/Application\ Support/Code/User/settings.json
	cp ./vscode/keybindings.json $(HOME)/Library/Application\ Support/Code/User/keybindings.json