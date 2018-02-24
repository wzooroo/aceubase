FROM phusion/baseimage:master

# Set correct environment variables
ENV DEBIAN_FRONTEND=noninteractive HOME="/root" TERM=xterm LANG=de_DE.UTF-8 LANGUAGE=de_DE:en LC_ALL=de_DE.UTF-8

# set ports
EXPOSE 8621 62062 9944 9903 6878

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Add required files that are local
ADD src/ /root/

# Set the locale
RUN locale-gen de_DE.UTF-8 && \

# Fix a Debianism of the nobody's uid being 65534
usermod -u 99 nobody && \
usermod -g 100 nobody && \

#set start file
mv /root/start.sh /etc/my_init.d/start.sh && \
chmod +x /etc/my_init.d/start.sh && \

# update apt and install dependencies
apt-get update -y && \
apt-get upgrade -y && \
apt-get install -y \
ca-certificates \
supervisor \
wget \
mc \
nano \
net-tools \
psmisc \
unzip \
libpython2.7 \
python-setuptools \
python-m2crypto \
python-apsw \
python-m2ext \
libxslt1.1 \ 
wrapsrv && \
mkdir -p /mnt/media/playlists && \

#acestream
wget -o - http://dl.acestream.org/linux/acestream_3.1.16_ubuntu_16.04_x86_64.tar.gz && \
tar -zxvf acestream_3.1.16_ubuntu_16.04_x86_64.tar.gz && \
mv acestream_3.1.16_ubuntu_16.04_x86_64 /opt/acestream && \

# set supervisor file
mv /root/supervisord.conf /etc/supervisor/conf.d/supervisord.conf && \
mv /root/supervisor/supervisord.conf /etc/supervisor/supervisord.conf && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/acestream/data/plugins/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man && \
(( find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true )) && \
(( find /usr/share/doc -empty|xargs rmdir || true ))
