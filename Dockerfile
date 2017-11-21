FROM alpine:latest

MAINTAINER K.Kato

ENV LANG=C.UTF-8 \
    MECAB_VERSION=0.996 \
    IPADIC_VERSION=2.7.0-20070801

RUN apk add --update --no-cache --virtual=build-deps \
    boost-dev g++ make \
    && wget -q http://mecab.googlecode.com/files/mecab-$MECAB_VERSION.tar.gz \
    && tar Jxfv mecab-$MECAB_VERSION.tar.gz \
    && cd mecab-$MECAB_VERSION/ \
    && ./configure --enable-utf8-only --wth-charset=utf8 \
    && make \
    && make install \
    && make clean \
    && cd .. \
    && rm mecab-$MECAB_VERSION.tar.gz \
    && wget -q http://mecab.googlecode.com/files/mecab-ipadic-$IPADIC_VERSION.tar.gz \
    && tar Jxfv mecab-ipadic-$IPADIC_VERSION.tar.gz \
    && cd mecab-ipadic-$IPADIC_VERSION/ \
    && ./configure --wth-charset=utf8 \
    && make \
    && make install \
    && make clean \ 
    && rm -rf /var/cache/* \
    && apk del build-deps \
    && apk add --update --no-cache boost 

CMD ["mecab", "-d"]
