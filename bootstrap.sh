#!/usr/bin/env bash

sudo yum update && sudo yum -y install zsh git

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install powerlevel 10k
sed -i 's\ZSH_THEME="robbyrussell"\ZSH_THEME="powerlevel10k/powerlevel10k"\' ~/.zshrc
cp .p10k.zsh ~
cat << EOF >> ~/.zshrc

# To customize prompt, run \`p10k configure\` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOF

# Install Oh My Zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

sed -i 's/plugins=(git)//' ~/.zshrc
cat << EOF >> ~/.zshrc

# Plugins list
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)
EOF

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Change shell (chsh not available by default)
sudo yum install -y util-linux-user
sudo chsh -s $(which zsh) $(whoami)
