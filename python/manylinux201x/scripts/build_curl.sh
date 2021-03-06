#!/bin/bash -ex
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

export CURL_VERSION="7.70.0"
export PREFIX="/usr/local"

NCORES=$(($(grep -c ^processor /proc/cpuinfo) + 1))

curl -sL "http://curl.haxx.se/download/curl-${CURL_VERSION}.tar.bz2" -o curl-${CURL_VERSION}.tar.bz2
tar xf curl-${CURL_VERSION}.tar.bz2
pushd curl-${CURL_VERSION}

./configure \
    --prefix=${PREFIX} \
    --disable-ldap \
    --disable-ldaps \
    --disable-rtsp \
    --disable-telnet \
    --disable-tftp \
    --disable-pop3 \
    --disable-imap \
    --disable-smb \
    --disable-smtp \
    --disable-gopher \
    --disable-mqtt \
    --disable-manual \
    --disable-shared \
    --with-ssl=${PREFIX} \
    --with-zlib=${PREFIX}

make -j${NCORES}
make install

popd

rm -r curl-${CURL_VERSION}.tar.bz2 curl-${CURL_VERSION}
