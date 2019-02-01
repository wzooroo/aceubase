FROM python:2.7.15-slim

# set ports
EXPOSE 8621 62062 6878 8081

# set config volume
VOLUME /mnt/films/

# Add required files that are local
ADD src/ /root/

# update apt and install dependencies
RUN \
apt-get update && apt-get upgrade -y && \
apt-get install -y --no-install-recommends \
python-pip \
pip install --upgrade psutil \
pip install --upgrade gevent \
wget \
mc \
nano && \
apt-get autoremove -y && \
mkdir -p /mnt/films && \

#acestream
cd /opt/ && \
wget -o - http://acestream.org/downloads/linux-beta/acestream_3.1.35_ubuntu_18.04_x86_64.tar.gz && \
tar -zxvf acestream_3.1.35_ubuntu_18.04_x86_64.tar.gz && \


# install aceproxy
wget -o - https://github.com/pepsik-kiev/HTTPAceProxy/archive/master.zip -O aceproxy.zip && \
unzip aceproxy.zip && \

# clean up
apt-get clean && \
rm -rf acestream_3.1.35_ubuntu_18.04_x86_64.tar.gz aceproxy.zip

RUN chmod +x /opt/start.sh

CMD ["/opt/start.sh"]




