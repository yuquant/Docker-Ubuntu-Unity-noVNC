#!/bin/bash

if [ ! -f $HOME/.vnc/passwd ] ; then

    if  [ -z "$PASSWORD" ] ; then
        PASSWORD=`pwgen -c -n -1 12`
	echo PASSWORD=$PASSWORD
        echo -e "PASSWORD = $PASSWORD" > $HOME/password.txt
    fi

    echo "$USER:$PASSWORD" | chpasswd

    # Set up vncserver
    su $USER -c "mkdir $HOME/.vnc && echo '$PASSWORD' | vncpasswd -f > $HOME/.vnc/passwd && chmod 600 $HOME/.vnc/passwd && touch $HOME/.Xresources"
    chown -R $USER:$USER $HOME


else
    # Set up vncserver
    su $USER -c "echo '$PASSWORD' | vncpasswd -f > $HOME/.vnc/passwd && chmod 600 $HOME/.vnc/passwd && touch $HOME/.Xresources"
    chown -R $USER:$USER $HOME


    VNC_PID=`find $HOME/.vnc -name '*.pid'`
    if [ ! -z "$VNC_PID" ] ; then
	echo "trying to use kill vnc pid"
        vncserver -kill :1
        rm -rf /tmp/.X1*
    fi

fi


if [ ! -z "$SUDO" ]; then
echo "trying to add sudo"
echo SUDO=$SUDO
    case "$SUDO" in
        [yY]|[yY][eE][sS])
            adduser $USER sudo
    esac
fi

if [ ! -z "$NGROK" ] ; then
	echo "trying to use NGROK"
	echo NGROK=$NGROK
        case "$NGROK" in		
            [yY]|[yY][eE][sS])
		
                su ubuntu -c "$HOME/ngrok/ngrok http 6080 --log $HOME/ngrok/ngrok.log --log-format json" &
                sleep 5
                NGROK_URL=`curl -s http://127.0.0.1:4040/status | grep -P "http://.*?ngrok.io" -oh`
                su ubuntu -c "echo -e 'Ngrok URL = $NGROK_URL/vnc.html' > $HOME/ngrok/Ngrok_URL.txt"
        esac
fi

/usr/bin/supervisord -n
