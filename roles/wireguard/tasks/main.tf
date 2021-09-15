- name: Template Out Wireguard Config(s)
  template:
    src: templates/wireguard.conf.j2
    dest: /etc/wireguard/{{ interface.name }}.conf
  loop: "{{ wireguard.interfaces|flatten(levels=1) }}"
  loop_control:
    loop_var: interface

