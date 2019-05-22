FROM liuweipeng/gpu-unity-zh:link
COPY startup.sh /home/ubuntu/startup.sh
EXPOSE 6080 5901 4040
CMD ["/bin/bash", "/home/ubuntu/startup.sh"]