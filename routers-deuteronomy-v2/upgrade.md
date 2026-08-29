# Upgrade

Administrative operations post-upgrade configurations

## database and kea dhcp
```bash
# set the credentials
$KEA_USER=
$KEA_DB=

systemctl restart mariadb && mariadb-upgrade -u root -p
systemctl status mariadb

systemctl stop kea-dhcp4
kea-admin db-upgrade mysql -n $KEA_DB -u $KEA_USER -p
# Enter the password

systemctl start kea-dhcp4
systemctl status kea-dhcp4
```
