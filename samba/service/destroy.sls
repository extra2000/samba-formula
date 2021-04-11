# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import SAMBA with context %}

samba-pod-destroy:
  cmd.run:
    - name: podman pod rm --force samba-pod
    - runas: {{ SAMBA.hostuser.name }}
