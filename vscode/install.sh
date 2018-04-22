#!/bin/bash

# Install VSCode packages
while read PACKAGE; do
  code --install-extension $PACKAGE
done < ./vscode/packages.txt
