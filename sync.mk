.PHONY: syncvscode
syncvscode:
	code --list-extensions > ./vscode/packages.txt
	cp $(HOME)/Library/Application\ Support/Code/User/settings.json ./vscode/settings.json
	cp $(HOME)/Library/Application\ Support/Code/User/keybindings.json ./vscode/keybindings.json