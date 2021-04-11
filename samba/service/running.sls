# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import SAMBA with context %}

samba-pod-destroy-if-exists:
  module.run:
    - state.sls:
      - mods:
        - samba.service.destroy

samba-pod-running:
  cmd.run:
    - name: podman play kube --network=sambanet samba-pod.yaml
    - cwd: /opt/samba
    - runas: {{ SAMBA.hostuser.name }}
    - require:
      - module: samba-pod-destroy-if-exists
