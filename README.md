# config_auto_redmi4x

auto boot when charge
auto adb tcp ip:5555
auto open termux

pkg update && pkg upgrade -y

pkg install wget -y

wget https://raw.githubusercontent.com/takumitesla/main/autoconfig.sh

chmod +x autoconfig.sh

./autoconfig.sh

tested on redmi 4x cheris os A12L
