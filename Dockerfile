# 临时添加功能用
FROM liuweipeng/dl:cuda11-novnc
COPY tigervnc.tar.gz /tmp/tigervnc.tar.gz
COPY noVNC.tar.gz /tmp/noVNC.tar.gz
RUN tar -xf /tmp/tigervnc.tar.gz -C /  && tar -xf /tmp/noVNC.tar.gz -C $HOME/
EXPOSE 6080
CMD ["/bin/bash", "/home/ubuntu/startup.sh"]
