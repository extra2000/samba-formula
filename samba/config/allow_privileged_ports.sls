# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import SAMBA with context %}

/etc/sysctl.d/02-allow-unprivileged-ports.conf:
  file.managed:
    - source: salt://samba/files/02-allow-unprivileged-ports.conf

sysctl -w net.ipv4.ip_unprivileged_port_start=139:
  cmd.run
