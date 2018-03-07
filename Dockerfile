FROM phusion/baseimage

# Set correct environment variables
ENV DEBIAN_FRONTEND=noninteractive HOME="/root" TERM=xterm LANG=ru_RU.UTF-8 LANGUAGE=ru_RU:en LC_ALL=ru_RU.UTF-8
WORKDIR /tmp
# set ports
EXPOSE 8621 62062 9944 9903 6878 8000 8844

# set config volume
VOLUME /mnt/media/playlists/
VOLUME /mnt/films/

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Add required files that are local
ADD src/ /root/

# Set the locale
RUN locale-gen ru_RU.UTF-8 && \

#set start file
mv /root/start.sh /etc/my_init.d/start.sh && \
chmod +x /etc/my_init.d/start.sh && \

# update apt and install dependencies
apt-get update -y && \
apt-get install -y \
supervisor \
wget \
mc \
nano \
net-tools \
htop \
nginx \
libpython2.7 \
python-m2crypto \
python-apsw \
python-pip && \
pip install --upgrade pip && \
pip install psutil --upgrade && \
pip install gevent --upgrade && \
apt-get purge python-pip -y && \
apt-get autoremove -y && \
mkdir -p /mnt/media/playlists && \
mkdir -p /mnt/films&& \

#acestream
wget -o - http://dl.acestream.org/linux/acestream_3.1.16_ubuntu_16.04_x86_64.tar.gz && \
tar -zxvf acestream_3.1.16_ubuntu_16.04_x86_64.tar.gz && \
mv acestream_3.1.16_ubuntu_16.04_x86_64 /opt/acestream && \

# install aceproxy
wget -o - https://github.com/pepsik-kiev/HTTPAceProxy/archive/master.zip -O aceproxy.zip && \
unzip aceproxy.zip -d /opt/ && \

# set supervisor file
mv /root/supervisord.conf /etc/supervisor/conf.d/supervisord.conf && \
mv /root/supervisor/supervisord.conf /etc/supervisor/supervisord.conf && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /opt/acestream/data/plugins/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man /usr/share/doc/*

WORKDIR /
