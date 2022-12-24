### Main install ###
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

### Plugins ###
## history-substring-search ##
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
sed -i -E 's/plugins=\((.*)\)/plugins=\(\1 zsh-history-substring-search\)/g' /home/fleet/.zshrc

## autosuggestions ##
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i -E 's/plugins=\((.*)\)/plugins=\(\1 zsh-autosuggestions\)/g' /home/fleet/.zshrc

## syntax-highlighting ##
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sed -i -E 's/plugins=\((.*)\)/plugins=\(\1 zsh-syntax-highlighting\)/g' /home/fleet/.zshrc

cat ~/.zshrc | grep plugins=