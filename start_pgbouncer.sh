#!/bin/bash

PGB_DIR=/etc/pgbouncer
INI=$PGB_DIR/pgbouncer.ini
USERLIST=$PGB_DIR/userlist.txt

rm $INI
rm $USERLIST

cat <<- END > $INI
    [databases]
    $PGB_DATABASES

    [pgbouncer]
    listen_port = $PGB_LISTEN_PORT
    listen_addr = $PGB_LISTEN_ADDR
    auth_type = md5
    auth_file = $USERLIST
    logfile = $PGB_DIR/pgbouncer.log
    pidfile = $PGB_DIR/pgbouncer.pid
    admin_users = $PGB_ADMIN_USERS
END

# TODO update to include proper encryption

# convert comma-separated string variables to arrays.
IFS=',' read -ra admin_array <<< "$PGB_ADMIN_USERS"
IFS=',' read -ra password_array <<< "$PGB_ADMIN_PASSWORDS"

# check every admin account has a corresponding password, and vice versa
# TODO does every admin account need a password? this might be an edge case.
if (( ${#admin_array[@]} != ${#password_array[@]} )); then
    exit 1
fi

# Zip admin arrays together and write them to userlist.
for (( i=0; i < ${#admin_array[*]}; ++i )); do
    echo "\"${admin_array[$i]}\" \"${password_array[$i]}\"" >> $USERLIST
done

chmod 0600 $INI
chmod 0600 $USERLIST

# start pgbouncer in current process, instead of a subshell
# TODO consider running pgb as a daemon with the -d flag instead
{ pgbouncer $INI ; }
