# shefos
------------------------------

Запуск установки

1)

Открыть терминал и выполнить следующие команды

2)
```bash
sudo su
```
3)
```bash
git clone https://github.com/linuxshef/shefos.git ; cd shefos ; ./shefos
```
-------------------------------

Запуск установки с рабочим столом Gnome

1)

Открыть терминал и выполнить следующие команды

2)
```bash
sudo su
```
3)
```bash
git clone https://github.com/linuxshef/shefos.git ; cd shefos ; ./gnome
```

-------------------------------

Neofetch из скрипта, скопировать команду и вставить в терминал

```bash
sudo pacman -Syy git lolcat --noconfirm ;  git clone https://github.com/linuxshef/shefos.git ; rm -Rf ~/.config/neofetch/config.conf ; mv shefos/config/neofetch/config.conf ~/.config/neofetch/ ; rm -Rf shefos
```

-------------------------------


Набор пакетов с AUR

ananicy-cpp ananicy-rules grub-customizer-git zramswap stacer-bin hardinfo sddm-config-editor-git antimicrox xdman8 ttf-ms-fonts ttf-tahoma system-monitoring-center onlyoffice-bin gconf  lib32-gconf python-proxy_tools python-pywebview


-------------------------------


Еслм по какой-то причине пакеты с AUR не доустановились , вы можете доустановить их вручную с помощью следующей команды , скопируйте и вставьте ее в терминал
```bash
git clone https://github.com/linuxshef/shefos.git ; cd shefos ; ./aurfix ; rm -Rf shefos ; sleep 2 ; reboot
```

--------------------------------
