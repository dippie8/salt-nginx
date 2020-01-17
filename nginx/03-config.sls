copy-conf-file:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://{{ slspath }}/archive/nginx.conf

set-selinux-variable:
  selinux.boolean:
    - name: httpd_can_network_connect
    - value: true
    - persist: true
    - require:
      - pkg: install-nginx
      - file: copy-conf-file
      
start-nginx:
  service.running:
    - name: nginx
    - watch:
      - file: /etc/nginx/nginx.conf
    - require:
      - selinux: set-selinux-variable