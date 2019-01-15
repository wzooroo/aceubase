FROM ubuntu:disco

ENV DEBIAN_FRONTEND=noninteractive

# set ports
EXPOSE 8621 62062 6878 8000

# set config volume
VOLUME /mnt/films/

# update apt and install dependencies
RUN \
apt-get update -y && \
apt-get install -y \
python3 \
python3-pip \
nano \
tzdata \
unzip \
htop \
wget && \
ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
dpkg-reconfigure --frontend noninteractive tzdata && \
pip3 install --upgrade psutil && \
pip3 install --upgrade gevent && \
apt-get autoremove -y && \
mkdir -p /mnt/films && \

#acestream
wget https://sybdata.de/data/acestream/acestream_3.1.33.1_x86_wbUI.tar.gz && \
tar -zxvf acestream_3.1.33.1_x86_wbUI.tar.gz && \
mv acestream.engine/ /opt/ && \

# install aceproxy
wget -O - https://github.com/pepsik-kiev/HTTPAceProxy/archive/master.zip -O aceproxy.zip && \
unzip aceproxy.zip -d /opt/ && \

# cleanup
rm -rf acestream_3.1.33.1_x86_wbUI.tar.gz aceproxy.zip

# add local files
COPY root/ /
RUN chmod +x /opt/acestream.engine/start.sh

CMD ["/opt/acestream.engine/start.sh"]


