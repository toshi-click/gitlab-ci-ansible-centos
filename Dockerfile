FROM centos:7

# 作成者情報
MAINTAINER toshi <toshi@toshi.click>

# set ENV
ENV LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja \
    LC_ALL=ja_JP.UTF-8

RUN yum install -y epel-release && yum -y groupinstall "Development Tools"
RUN yum install -y ansible libselinux-python selinux-policy && yum clean all
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 \
    && unlink /etc/localtime \
    && ln -s /usr/share/zoneinfo/Japan /etc/localtime

