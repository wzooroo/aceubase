FROM phusion/baseimage:master

# Set correct environment variables
ENV DEBIAN_FRONTEND=noninteractive HOME="/root" TERM=xterm LANG=ru_RU.UTF-8 LANGUAGE=ru_RU:ru LC_ALL=ru_RU.UTF-8
WORKDIR /tmp
# set ports
EXPOSE 8621 62062 6878 8000

# set config volume
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
apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
apt-get install -y \
python3 \
curl \
wget \
mc \
nano \
tzdata \
htop && \
apt-get autoremove -y && \
mkdir -p /mnt/films && \

#acestream
wget -o - http://acestream.org/downloads/linux-beta/acestream_3.1.35_ubuntu_18.04_x86_64.tar.gz && \
tar -zxvf acestream_3.1.35_ubuntu_18.04_x86_64.tar.gz && \
mv acestream_3.1.35_ubuntu_18.04_x86_64 /opt/acestream && \

# install aceproxy
wget -o - https://github.com/pepsik-kiev/HTTPAceProxy/archive/master.zip -O aceproxy.zip && \
unzip aceproxy.zip -d /opt/ && \

# set /tmp on tmpfs
echo "tmpfs /tmp tmpfs rw,nosuid,nodev 0 0" | tee -a /etc/fstab && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /opt/acestream/data/plugins/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man /usr/share/doc/*

WORKDIR /

