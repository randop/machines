# git server

## setup
```bash
pacman -Syy git haproxy nginx fcgiwrap cgit
systemctl enable --now fcgiwrap.socket
systemctl enable --now haproxy
systemctl enable --now nginx
```

## init a repo
```bash
su -s /bin/sh -c "git init --bare /var/ci/repos/methuselah.git" ci
```
