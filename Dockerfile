FROM centos:7

# 作成者情報
MAINTAINER toshi <toshi@toshi.click>

# set ENV
ENV container docker \
    LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja \
    LC_ALL=ja_JP.UTF-8

RUN yum -y update && yum install -y epel-release && yum -y groupinstall "Development Tools" && yum clean all
RUN yum install -y ansible systemd libselinux-python selinux-policy && yum clean all
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 \
    && unlink /etc/localtime \
    && ln -s /usr/share/zoneinfo/Japan /etc/localtime

# CIテスト用にsystemdを有効にする
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
    systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]

ADD ansible.cfg /etc/ansible/ansible.cfg

CMD ["/usr/sbin/init"]
