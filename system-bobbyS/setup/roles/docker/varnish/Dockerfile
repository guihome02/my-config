FROM cooptilleuls/varnish:6.0

RUN apt-get update -y && \
	apt-get install -y libvarnishapi-dev pkg-config make wget && \
	cd /tmp && \
	wget https://download.varnish-software.com/varnish-modules/varnish-modules-0.15.0.tar.gz && \
	tar -xzf varnish-modules-0.15.0.tar.gz && \
	cd varnish-modules-0.15.0 && \
	./configure && \
	make && \
	make install && \
	cd / && \
	apt-get autoremove -y pkg-config make wget && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY fos /usr/local/etc/varnish/fos/
COPY default.vcl /usr/local/etc/varnish/
