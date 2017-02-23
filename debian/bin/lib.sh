export BUILDDEPS="make gcc g++ libc-dev ruby-dev wget bzip2"
export RUNDEPS="ca-certificates ruby libsystemd0 procps"
export JEMALLOC_VERSION="4.4.0"
export DEBIAN_FRONTEND=noninteractive

install_dependencies () {
  apt-get install -y --no-install-recommends $RUNDEPS $BUILDDEPS
}

remove_builddeps () {
 apt-get purge -y \
   --auto-remove \
   -o APT::AutoRemove::RecommendsImportant=false \
   $BUILDDEPS
  rm -rf /var/lib/apt/lists/*
  rm -rf /tmp/*
}

install_bundler () {
  echo 'gem: --no-document' >> /etc/gemrc
  gem update --system
  gem install bundler
}

install_libjemalloc () {
   wget -O "/tmp/jemalloc-$JEMALLOC_VERSION.tar.bz2" "https://github.com/jemalloc/jemalloc/releases/download/$JEMALLOC_VERSION/jemalloc-$JEMALLOC_VERSION.tar.bz2"
   cd /tmp
   tar -xjf "jemalloc-$JEMALLOC_VERSION.tar.bz2"
   cd "jemalloc-$JEMALLOC_VERSION"
   ./configure
   make
   mv lib/libjemalloc.so.2 /usr/lib
}
