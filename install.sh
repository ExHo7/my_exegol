# Installing my_exegol resources
echo "Installing my_exegol resources..."
git clone https://github.com/ExHo7/my_exegol.git
cd my_exegol
cp conf/tmux.conf ~/.exegol/my_resources/tmux/tmux.conf
cp conf/aliases ~/.exegol/my_resources/zsh/aliases
wget -qO- https://raw.githubusercontent.com/ExHo7/my_exegol/main/load_user_setup.sh && cat load_user_setup.sh > ~/.exegol/my_resources/load_user_setup.sh
cd .. && rm -rf my_exegol
echo "my_exegol resources successfully installed !"
