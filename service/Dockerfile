FROM openjdk:8-jre

#WORKDIR /home/dip
#=======================
# Install utils
#=======================
COPY docker-scripts/install-default.sh install-default.sh 
RUN ["/bin/bash", "install-default.sh"]

RUN mkdir -p /home/dip/gobblin-dist
WORKDIR /home/dip/gobblin-dist
COPY gobblin-distribution-0.13.0.tar.gz ./

ENV TERM xterm

ADD support ./support

RUN set -eux; \
#cd /home/dip; \
tar -xvf gobblin-distribution-0.13.0.tar.gz --strip-components=1; \
rm gobblin-distribution-0.13.0.tar.gz; \
mkdir -p /home/dip/gobblin-dist/logs; \
mkdir -p /home/dip/gobblin-dist/templates; \
mkdir -p /home/dip/gobblin-dist/service-work-dir; \
mkdir -p /home/dip/gobblin-dist/cluster-job-config-bpu1;

COPY entry.sh ./ 
CMD ./entry.sh
