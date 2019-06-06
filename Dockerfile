# 临时添加功能用
FROM liuweipeng/gpu-unity-zh:link
COPY startup.sh /home/ubuntu/startup.sh
COPY restartunity /home/ubuntu/restartunity
COPY supervisor.conf /etc/supervisor/conf.d/supervisor.conf 
EXPOSE 6080 5901 4040
CMD ["/bin/bash", "/home/ubuntu/startup.sh"]
