#!/bin/bash



# This is a setup script for Linux systems. I distro hop a LOT so this is handy for me!



#Main Menu
#|
#|------ Packages (Debian/Arch/Fedora)
#|
#|------ Configs (Swap/Bluetooth)
#|
#|------ Rice (i3 wm + polybar)



# Packages:


Packages(){

 Distro= ""

 read -p "Choose your distro (Mint/Arch/Fedora): " Distro

 if [[ "$Distro" = "Mint" || "$Distro" = "mint" ]];
 then
	 # APT packages:

	 sudo apt update && sudo apt upgrade

	 sudo apt install i3 kitty rofi feh lxpolkit polybar vlc picom picom-conf wget tlp neovim steam

	 sudo apt install wine-installer git lxappearance numlockx pavucontrol cmatrix cava htop tty-clock gimp

         # Flatpaks:

	 flatpak install flathub dev.vencord.Vesktop net.lutris.Lutris

         # Setup:

	 sudo systemctl enable tlp

 else

     echo "Coming soon..."



 fi
         
}



# Configs

Configs(){

	# Swappiness:

	answer=""

	read -p "Add 'vm.swappiness=10' to the config file, understood? (type anything to proceed) : " answer
	
	sudo nvim /etc/sysctl.d/99-swappiness.conf

	# Bluetooth:
	
	cd ~/Mint-install/
	
	sudo cp input.conf /etc/bluetooth/

        # System refresh:

	sudo sysctl --system

}


# Ricing (The fun part :3)


Rice(){

	# Cloning the repo..
	
	cd ~
	
	git clone https://github.com/Friskyy-06/violet-3.git

	cd violet-3/dotfiles/

	cp -r i3 kitty polybar ~/.config

	cp pink.png ~/Pictures

	cd ~/.config/polybar/

	chmod +x launch.sh

	# Fonts:
	
        cd ~

	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.5.1/MartianMono.zip

	unzip MartianMono.zip -d ~/.fonts/

	# Rofi:
	
	git clone https://github.com/lr-tech/rofi-themes-collection.git

	cd rofi-themes-collection

	mkdir -p ~/.local/share/rofi/themes/

        cp themes/rounded-purple-dark.rasi ~/.local/share/rofi/themes/

        cp -r themes/template  ~/.local/share/rofi/themes/


}


main(){

  option=""

  echo "-----------------[Mint install :3]--------------------"
  echo "                                                      "
  echo "     1- Install packages            2- Configs        "
  echo "                                                      "
  echo "     3- Rice :3                     4- Exit           "
  echo "                                                      "
  echo "------------------------------------------------------"
  echo "                                                      "


  read -p "Pick an option: " option

  if [[ "$option" = "1" ]];
  then
      Packages
  
  elif [[ "$option" = "2" ]];
  then
      Configs

  elif [[ "$option" = "3" ]];
  then
      Rice

  elif [[ "$option" = "4" ]];
  then
      exit
  else
	echo "Invalid choice!"

  fi

}

while [[ "1" = "1" ]];
 do
	main
done
