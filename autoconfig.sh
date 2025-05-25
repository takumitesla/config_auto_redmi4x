#!/system/bin/sh

start(){
    echo "change mode to read,write.."
    if mount -o rw,remount /; then
        echo "success"
    else
        echo "remount failed"
        exit 1
    fi
}

auto_open_termux(){

    # Path ke file autotermux.sh
    AUTO_TERMUX="/data/adb/service.d/autotermux.sh"

    # Konten script yang akan ditambahkan
    NEW_CONTENT=$(cat << 'EOF'
#!/system/bin/sh
while [ "$(getprop sys.boot_completed | tr -d '\n')" != "1" ]; do
    sleep 1
done
sleep 5
am start -n com.termux/.app.TermuxActivity
exit 
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
        Efinish
    fi
}


auto_adb_port_5555(){
    # Path ke file build.prop
    BUILD_PROP="/system/build.prop"
    
    # Baris yang akan ditambahkan
    NEW_LINE="\nservice.adb.tcp.port=5555"
    
    # Cek apakah file build.prop dapat ditulis
    if [ -w "$BUILD_PROP" ]; then
        # Tambahkan baris di bagian paling bawah jika belum ada
        if ! grep -qx "$NEW_LINE" "$BUILD_PROP"; then
            echo -e "$NEW_LINE" >> "$BUILD_PROP"
            echo "Baris berhasil ditambahkan ke $BUILD_PROP."
        else
            echo "Baris sudah ada di $BUILD_PROP."
        fi
    else
        echo "Tidak dapat menulis ke $BUILD_PROP. Pastikan Anda memiliki izin root."
        Efinish
    fi
}

auto_boot(){
    # Path ke file autoboot.rc
    AUTOBOOT_RC="/system/etc/init/autoboot.rc"
    
    # Baris yang akan ditambahkan
    NEW_CONTENT="on charger\nsetprop sys.powerctl reboot"
    
    # Jika file tidak ada, buat file kosong terlebih dahulu
    if [ ! -f "$AUTOBOOT_RC" ]; then
        touch "$AUTOBOOT_RC"
        chmod 644 "$AUTOBOOT_RC"
        echo "File $AUTOBOOT_RC berhasil dibuat."
    fi

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
        Efinish
    fi
}

finish(){
    echo "change mode to read only.."
    mount -o ro,remount /
    echo "success"
}

Efinish(){
    finish
    exit 1
}

start_config(){
    start
    auto_open_termux
    auto_adb_port_5555
    auto_boot
    finish
    echo "all completed."
    exit 0
}

clear || echo -e "\033c"
pkg install figlet -y
clear || echo -e "\033c"
echo "AUTOCONF"
echo -e "version : 1.0.0\n"
echo -e "\n"
echo "by Takumi Tesla"
echo "github : https://github.com/takumitesla"


# Cek apakah perangkat memiliki akses root
if which su >/dev/null 2>&1; then
    
    echo "The device is rooted."
    sleep 1
    echo "start program.."
    sleep 1
    start_config
else
    echo "Are you rooted?"
    exit 1
fi
