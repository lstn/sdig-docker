FROM debian:stretch-20190708 as sdig-builder

ENV PDNS_TOOLS_VERSION=4.2.0~rc1-2


RUN echo deb http://http.debian.net/debian experimental main contrib non-free | \ 
    tee /etc/apt/sources.list.d/experimental.list && \
    echo deb http://http.debian.net/debian stretch-backports main contrib non-free | \ 
    tee /etc/apt/sources.list.d/stretch-backports.list && \
    apt-get update -qq && apt-get install -y pdns-tools=$PDNS_TOOLS_VERSION binutils

#RUN readelf -d /usr/bin/sdig  | grep 'NEEDED'

FROM gcr.io/distroless/base

COPY --from=sdig-builder /usr/bin/sdig /usr/bin/sdig
COPY --from=sdig-builder ["/lib/x86_64-linux-gnu/libc*", \
         "/lib/x86_64-linux-gnu/libpthread*", \ 
         "/lib/x86_64-linux-gnu/libm.*", \
         "/lib/x86_64-linux-gnu/libgcc_s*", \  
         "/lib/x86_64-linux-gnu/"]


COPY --from=sdig-builder ["/usr/lib/x86_64-linux-gnu/libcrypto*", \
         "/usr/lib/x86_64-linux-gnu/libstdc++*", \
         "/usr/lib/x86_64-linux-gnu/libatomic*", \
         "/usr/lib/x86_64-linux-gnu/"]

ENTRYPOINT ["/usr/bin/sdig"]
CMD ["--help"]

