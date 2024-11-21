set -u
set -e
debootstrap --no-check-certificate --no-check-gpg --components=main,universe,multiverse --include=vim,build-essential,git,redis-server,lua5.1,postgresql,libpq-dev,python3.12-dev,python3-dev,memcached,libperl-dev,ruby,ruby-dev,wget,language-pack-en,libcurl4-openssl-dev,mysql-server,libyajl-dev,beanstalkd,ssh,rsync,libluajit-5.1-dev,curl,liblocal-lib-perl,python3-pip,libpcre3-dev,libjansson-dev,quota,gawk,libreadline-dev,libyaml-dev,libsqlite3-dev,sqlite3,autoconf,libgdbm-dev,libncurses-dev,automake,libtool,bison,libffi-dev,libxml2-dev,libdb-dev,libbz2-dev,libjpeg-dev,libpng-dev,ruby-rack,postgresql-contrib,postgis,libxslt1-dev,sphinxsearch,libmysqlclient-dev,imagemagick,libreoffice,tesseract-ocr,tesseract-ocr-ita,wkhtmltopdf,graphicsmagick,poppler-utils,ghostscript,language-pack-it,language-pack-de,language-pack-es,language-pack-pt,language-pack-pl,nullmailer,nodejs,nano,htop,emacs,mercurial,screen,apache2-utils,unzip,erlang-nox,libdatetime-perl,libmemcached-dev,libapache2-mod-svn,libapache2-mod-xsendfile,libcap2-bin,libcap-dev,libode-dev,gettext,libapache2-mod-rpaf,graphviz,strace,bind9-host,bc,pastebinit,tmux,mc,zip,xmlsec1,libxmlsec1-dev,attr,acl,libssh2-1-dev,libkrb5-dev,python3-virtualenv,libgeo-ip-perl,virtualenv,subversion,ftp,libgeoip-dev,libattr1-dev,telnet,npm,golang,erlang,ffmpeg,unoconv,libfl-dev,libzmq3-dev,libdbd-pg-perl,libdbd-mysql-perl,openjdk-8-jdk,node-clean-css,node-less,apache2,apache2-dev,virtualenvwrapper,net-tools,nginx,libsodium-dev,cmake,pkg-config noble /distros/noble
chroot /distros/noble /bin/bash -x <<'EOF'
set -u
set -e
dpkg-reconfigure tzdata
echo "exit 101" > /usr/sbin/policy-rc.d
chmod 755 /usr/sbin/policy-rc.d
mkdir /.old_root
ln -s /proc/self/mounts /etc/mtab
mkdir /containers
mkdir -p /opt/unbit/uwsgi/plugins
rm /etc/hosts /etc/hostname
ln -s /run/resolvconf/hostname /etc/hostname
ln -s /run/resolvconf/hosts /etc/hosts
cd /root
git clone https://github.com/unbit/nss-unbit
cd nss-unbit
make
EOF
cp nsswitch.conf /distros/noble/etc/nsswitch.conf
cp shortcuts.ini /distros/noble/opt/unbit/uwsgi/shortcuts.ini
