# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import SAMBA with context %}

/opt/samba:
  file.directory:
    - user: {{ SAMBA.hostuser.name }}
    - group: {{ SAMBA.hostuser.group }}

/home/{{ SAMBA.hostuser.name }}/.config/cni/net.d:
  file.directory:
    - user: {{ SAMBA.hostuser.name }}
    - group: {{ SAMBA.hostuser.group }}
    - makedirs: true

/home/{{ SAMBA.hostuser.name }}/.config/cni/net.d/podman-network-sambanet.conflist:
  file.managed:
    - source: salt://samba/files/podman-network-sambanet.conflist.jinja
    - user: {{ SAMBA.hostuser.name }}
    - group: {{ SAMBA.hostuser.group }}
    - template: jinja
    - context:
      pod: {{ SAMBA.pod }}

/opt/samba/src:
  file.recurse:
    - source: salt://samba/files/samba
    - user: {{ SAMBA.hostuser.name }}
    - group: {{ SAMBA.hostuser.group }}
    - show_changes: false
    - file_mode: keep

/opt/samba/samba-pod.yaml:
  file.managed:
    - source: salt://samba/files/samba-pod.yaml
    - user: {{ SAMBA.hostuser.name }}
    - group: {{ SAMBA.hostuser.group }}
    - template: jinja
    - context:
      samba: {{ SAMBA }}
