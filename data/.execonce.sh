#!/system/bin/sh
# Released under GPLv3 - bashintosh (2015)

APPDIR="/data/.execonce"

BB="/sbin/busybox"
RM="$BB rm"
LS="$BB ls"
CHMOD="$BB chmod"
SLEEP="$BB sleep"

$CHMOD 0777 /data
$CHMOD -R 0777 $APPDIR

until [ -n "$($BB pidof -s com.android.launcher)" ]; do
	$SLEEP 1
done

log -p i -t Execonce "Init successfully executing first boot package installer"

if [ -d $APPDIR ]; then
	if [ "$($LS $APPDIR)" ]; then
		cd $APPDIR
		for pkg in *.apk; do
			log -p i -t Execonce "Installing: $pkg"
			pm install -r $APPDIR/$pkg
		done
	fi
fi

$CHMOD 0771 /data

log -p i -t Execonce "Success! Self-destructing script.."

$RM /data/.execonce.sh &>/dev/null
$SLEEP 1
$RM -r $APPDIR &>/dev/null

exit 0
