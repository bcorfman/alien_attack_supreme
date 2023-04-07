FROM ubuntu

ARG GODOT_VERSION='4.0.2'
ARG GODOT_RELEASES_DOWNLOAD='https://github.com/godotengine/godot/releases/download'

ENV GODOT_VERSION=$GODOT_VERSION

RUN apt-get update -qq \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
    ca-certificates \
    curl \
    libfontconfig1 \
    unzip \
 && update-ca-certificates

RUN mkdir /tmp/godot && cd /tmp/godot \
 && curl -fsSL "${GODOT_RELEASES_DOWNLOAD}/${GODOT_VERSION}-stable/Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip" -o godot.zip \
 && curl -fsSL "${GODOT_RELEASES_DOWNLOAD}/${GODOT_VERSION}-stable/Godot_v${GODOT_VERSION}-stable_export_templates.tpz" -o tpl.tpz \
 && unzip godot.zip \
 && mv "Godot_v${GODOT_VERSION}-stable_linux.x86_64" /usr/local/bin/godot \
 && chmod +x /usr/local/bin/godot \
 && unzip tpl.tpz \
 && mkdir -p /usr/local/share/godot/export_templates/${GODOT_VERSION}.stable/ \
 && mv templates/* /usr/local/share/godot/export_templates/${GODOT_VERSION}.stable/ \
 && rm -rf godot.zip tpl.tpz templates

COPY gexport.sh /usr/local/bin/gexport
RUN chmod +x /usr/local/bin/gexport