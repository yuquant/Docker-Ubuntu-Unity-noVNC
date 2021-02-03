# Docker-Ubuntu-Unity-noVNC中文桌面版

## 更新特色:
- 可以自由选择cuda版本做深度学习
- 解决了compiz unity-setting 等cpu持续增长问题 
- 直接通过ip登陆
- 移动端及PC端打开后屏幕分辨率自适应调整
- 增加中文显示支持,添加了搜狗输入法,通过Ctrl+Space切换
- 修复了vnc密码无法继续修改的bug  
Dockfile for Ubuntu with Unity desktop environment and noVNC. 

This **Image/Dockerfile** aims to create a container for **Ubuntu 16.04** with **Unity Desktop** and using **TightVNCServer**, **noVNC** which allow user use browser to log in into this container.


## How to use?

You can build this **Dockerfile** yourself:

```
sudo docker build -t "yuquant/ubuntu-unity-novnc" .
```

Or, just pull my **image**:

```
sudo docker pull yuquant/ubuntu-unity-novnc
```

The default usage of this image is:

```
sudo docker run -itd -p 80:6080 yuquant/ubuntu-unity-novnc
```

Wait for a few second, you can access http://localhost/vnc.html and see this screen:

![alt text](https://github.com/yuquant/Docker-Ubuntu-Unity-noVNC/raw/master/noVNC.png "vnc.html")


### Password

In default, the **password** will create randomly, to find the password, please using the following command:

```
sudo docker exec $CONTAINER_ID cat /home/ubuntu/password.txt
```

And you can use this password to log in into this container.

After log in, you can see this screen:

![alt text](https://github.com/yuquant/Docker-Ubuntu-Unity-noVNC/raw/master/desktop.png "Unity desktop")


## Arguments

This image contains 3 input argument:

1. Password

   You can set your own user password as you like:
   ```
   sudo docker run -itd -p 80:6080 -e PASSWORD=$YOUR_PASSWORD yuquant/ubuntu-unity-novnc
   ```
   Now, you can user your own password to log in.

2. Sudo

   In default, the user **ubuntu** will not be the sudoer, but if you need, you can use this command:
   ```
   sudo docker run -d -p 80:6080 -e SUDO=yes yuquant/ubuntu-unity-novnc
   ```

   This command will grant the **sudo** to user **ubuntu**.

   And use **SUDO=YES**, **SUDO=Yes**, **SUDO=Y**, **SUDO=y** are also supported.

   To check the sudo is work , when you open **xTerm** it should show following message:
   ```
   To run a command as administrator (user "root"), use "sudo <command>".
   See "man sudo_root" for details.
   ```
   **Caution!!** allow your user as sudoer may cause security issues, use it carefully.
   如果想禁止使用su用户,可执行以下命令
   ```
   sudo docker run -d -p 80:6080 -e SUDO=no yuquant/ubuntu-unity-novnc
   ```
   
## 添加环境变量,在 /etc/bash.bashrc后添加即可
export PATH=/mnt/command:$PATH
export PATH=/mnt/venv/bin:$PATH

## Issues
部分docker cpu占用缓慢增长的情况,通过restartunity定期重启桌面解决    
Can't work properly with gnome-terminal, use XTerm to place it.

Some components of Unity may not work properly with vncserver.
