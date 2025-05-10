# Config Auto Redmi 4X

A set of automation scripts for Redmi 4X running Cheris OS A12L, enabling automatic configuration during boot, including:  
- Auto boot when charging  
- Auto enable ADB over TCP/IP (`tcp:5555`)  
- Auto open Termux after booting  

## Features
- **Auto Boot on Charge:** Automatically powers on the device when connected to a charger.  
- **Auto ADB over TCP/IP:** Enables ADB over the network on port 5555, allowing remote debugging and control.  
- **Auto Start Termux:** Opens the Termux app automatically after the device boots.  

---

## How to Install
Follow these steps to set up the automation scripts on your Redmi 4X:

### Step 1: Update and Install wget
```
pkg update && pkg upgrade -y
pkg install wget -y
```

### Step 2: Download the Auto Configuration Script
```
wget https://raw.githubusercontent.com/takumitesla/config_auto_redmi4x/main/autoconfig.sh
```

### Step 3: Grant Execute Permission
```
chmod +x autoconfig.sh
```

### Step 4: Run the Script as Root
```
su -c "./autoconfig.sh"
```

---

## Requirements
- Rooted device (Redmi 4X)  
- Cheris OS A12L (Tested and verified)  
- Magisk for root access  

---

## Recommended Kernel for Overclocking
To enhance performance, you can use the following overclocking kernel:  
- **Kernel for Overclocking CPU:**  
  [Download Kernel](https://drive.google.com/file/d/1QvNwubnX5tFb6bu1H3KF9fRam4mIR3am/view)  

### Install Kernel via Recovery:
1. Boot into recovery mode.  
2. Flash the downloaded kernel ZIP.  
3. Reboot the device.  

---

## ROM Information
- **Tested ROM:** Cheris OS A12L  
- **Download ROM:**  
  [Download Link](https://drive.usercontent.google.com/download?id=19W5GmZ7l9AA9xDJuLtw0DMtG133wi1pK&export=download&authuser=0)  

---

## Root Access with Magisk
Magisk is required for the script to work properly.  
- **Magisk Download:**  
  [Magisk v28.1](https://github.com/topjohnwu/Magisk/releases/tag/v28.1)  

### Install Magisk:
1. Flash the Magisk ZIP via recovery.  
2. Reboot and verify root access.  

---

## Troubleshooting
- **Device not booting on charge:**  
  Ensure that the `autoboot.rc` file is created correctly.  
- **ADB over TCP/IP not working:**  
  Check the `build.prop` file for the `service.adb.tcp.port=5555` entry.  
- **Termux does not open after boot:**  
  Make sure the script is correctly placed in `/data/adb/service.d/` and has execute permissions.  
  ```
  chmod 755 /data/adb/service.d/autotermux.sh
  ```  

---

## Contributing
Feel free to contribute to this project by forking the repository and creating a pull request.  
For any issues, please open a new issue on GitHub.  

---

## Contact
Developed by **Takumi Tesla**  
- GitHub: [Takumi Tesla](https://github.com/takumitesla)  
- Email: takumitesla@gmail.com  

---

## License
This project is licensed under the MIT License.  

