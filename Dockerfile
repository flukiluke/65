FROM ubuntu:21.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends libx11-6 libgl1 libglu1-mesa && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m lbasic

COPY lbasic /usr/local/bin/lbasic
COPY stubs /usr/local/share/lbasic/stubs
WORKDIR /home/lbasic
USER lbasic
ENTRYPOINT ["/usr/local/bin/lbasic", "-t", "--preload", "/usr/local/share/lbasic/stubs/console-only.bas"]
