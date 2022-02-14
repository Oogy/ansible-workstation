PKGS=" 
  htop \
  termux-api \
  termux-auth \
  termux-keyring \
  termux-tools \
  termux-services \
  neovim \
  openssh \
  git \
  curl 
"

update_pkgs(){
  pkg update -y
}

install_pkgs(){
  update_pkgs
  pkg install -y $PKGS
}

main(){
  install_pkgs
  write_configs
  setup_ssh
}
