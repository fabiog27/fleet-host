### Main install ###
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

### Plugins ###
## history-substring-search ##
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
sed -i -E 's/plugins=\((.*)\)/plugins=\(\1 history-substring-search\)/g' test