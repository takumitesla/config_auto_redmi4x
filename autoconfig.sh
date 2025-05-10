#!/system/bin/sh

auto_open_termux(){

    # Path ke file autotermux.sh
    AUTO_TERMUX="/data/adb/service.d/autotermux.sh"

    # Konten script yang akan ditambahkan
    NEW_CONTENT=$(cat << 'EOF'
#!/system/bin/sh
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
done
am start -n com.termux/.app.TermuxActivity
exit 0
EOF
)

    # Cek apakah direktori dapat ditulis
    if [ -w "$(dirname "$AUTO_TERMUX")" ]; then
        # Tulis konten ke file dan atur izin
        printf "%s\n" "$NEW_CONTENT" > "$AUTO_TERMUX"
        chmod 755 "$AUTO_TERMUX"
        echo "Script berhasil ditulis ke $AUTO_TERMUX dan izin diatur ke 755."
    else
        echo "Tidak dapat menulis ke $(dirname "$AUTO_TERMUX"). Pastikan Anda memiliki izin root."
    fi
}


auto_adb_port_5555(){
    # Path ke file build.prop
    BUILD_PROP="/system/build.prop"
    
    # Baris yang akan ditambahkan
    NEW_LINE="service.adb.tcp.port=5555"
    
    # Cek apakah file build.prop dapat ditulis
    if [ -w "$BUILD_PROP" ]; then
        # Tambahkan baris di bagian paling bawah jika belum ada
        if ! grep -qx "$NEW_LINE" "$BUILD_PROP"; then
            echo "$NEW_LINE" >> "$BUILD_PROP"
            echo "Baris berhasil ditambahkan ke $BUILD_PROP."
        else
            echo "Baris sudah ada di $BUILD_PROP."
        fi
    else
        echo "Tidak dapat menulis ke $BUILD_PROP. Pastikan Anda memiliki izin root."
    fi
}

auto_boot(){
    # Path ke file autoboot.rc
    AUTOBOOT_RC="/system/etc/init/autoboot.rc"
    
    # Baris yang akan ditambahkan
    NEW_CONTENT="on charger\nsetprop sys.powerctl reboot"
    
    # Cek apakah file dapat ditulis
    if [ -w "$AUTOBOOT_RC" ]; then
        # Tambahkan baris di bagian paling bawah jika belum ada
        if ! grep -q "^on charger$" "$AUTOBOOT_RC"; then
            printf "%b\n" "$NEW_CONTENT" >> "$AUTOBOOT_RC"
            chmod 644 "$AUTOBOOT_RC"
            echo "Baris berhasil ditambahkan dan izin file diatur ke 644."
        else
            echo "Baris sudah ada di $AUTOBOOT_RC."
        fi
    else
        echo "Tidak dapat menulis ke $AUTOBOOT_RC. Pastikan Anda memiliki izin root."
    fi
}



# Versi program
__version__="1.0.0"

# ANSI Colors
RED="$(printf '\033[31m')"  
GREEN="$(printf '\033[32m')"  
ORANGE="$(printf '\033[33m')"  
CYAN="$(printf '\033[36m')"  
WHITE="$(printf '\033[37m')"  
RESET="$(printf '\033[0m')"

# Banner Function
banner() {
        cat <<- EOF
${RED}
${RED}          _    _ _______ ____     _____ ____  _   _ ______ 
${RED}     /\  | |  | |__   __/ __ \   / ____/ __ \| \ | |  ____|
${RED}    /  \ | |  | |  | | | |  | | | |   | |  | |  \| | |__   
${RED}   / /\ \| |  | |  | | | |  | | | |   | |  | | . ` |  __|  
${RED}  / ____ \ |__| |  | | | |__| | | |___| |__| | |\  | |     
${RED} /_/    \_\____/   |_|  \____/   \_____\____/|_| \_|_|     
${RED}                                                           
                                                                        
${RED}Version: ${__version__}${RESET}
    
${GREEN}[${WHITE}-${GREEN}]${CYAN} AutoConf by Takumi Tesla${WHITE}
EOF
}




start_config(){
    auto_open_termux
    auto_adb_port_5555
    auto_boot
}

clear || echo -e "\033c"
banner

# Cek apakah perangkat memiliki akses root
if which su >/dev/null 2>&1; then
    
    echo "The device is rooted."
    sleep 1
    echo "start program.."
    sleep 1
    start_config
else
    echo "Are you rooted?"
fi
