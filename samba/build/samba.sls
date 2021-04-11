# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import SAMBA with context %}

samba-image-present:
  cmd.run:
    - name: podman build -t {{ SAMBA.image.name }} -f Dockerfile .
    - cwd: /opt/samba/src
    - runas: {{ SAMBA.hostuser.name }}
