TMPDIR=/tmp
ZIPSET=zapret
ZIPSET6=zapret6
ZIPLIST=$EXEDIR/zapret-ip.txt
ZIPLIST6=$EXEDIR/zapret-ip6.txt
ZIPLIST_EXCLUDE=$EXEDIR/zapret-ip-exclude.txt
ZIPLIST_USER=$EXEDIR/zapret-ip-user.txt
ZIPLIST_USER6=$EXEDIR/zapret-ip-user6.txt
ZUSERLIST=$EXEDIR/zapret-hosts-user.txt
ZHOSTLIST=$EXEDIR/zapret-hosts.txt

ZIPSET_IPBAN=ipban
ZIPLIST_IPBAN=$EXEDIR/zapret-ip-ipban.txt
ZIPLIST_USER_IPBAN=$EXEDIR/zapret-ip-user-ipban.txt
ZUSERLIST_IPBAN=$EXEDIR/zapret-hosts-user-ipban.txt


getuser()
{
 [ -f $ZUSERLIST ] && {
  dig A +short +time=8 +tries=2 -f $ZUSERLIST | grep -E '^[^;].*[^.]$' | grep -vE '^192\.168\.[0-9]+.[0-9]+$' | grep -vE '^127\.[0-9]+\.[0-9]+\.[0-9]+$' | grep -vE '^10\.[0-9]+\.[0-9]+\.[0-9]+$' | sort -u >$ZIPLIST_USER
 }
 [ -f $ZUSERLIST_IPBAN ] && {
  dig A +short +time=8 +tries=2 -f $ZUSERLIST_IPBAN | grep -E '^[^;].*[^.]$' | grep -vE '^192\.168\.[0-9]+\.[0-9]+$' | grep -vE '^127\.[0-9]+\.[0-9]+\.[0-9]+$' | grep -vE '^10\.[0-9]+\.[0-9]+\.[0-9]+$' | sort -u >$ZIPLIST_USER_IPBAN
 }
}

getuser6()
{
 [ -f $ZUSERLIST ] && {
  dig AAAA +short +time=8 +tries=2 -f $ZUSERLIST | sort -u >$ZIPLIST_USER6
 }
}

cut_local()
{
  grep -vE '^192\.168\.[0-9]+\.[0-9]+$' |
  grep -vE '^127\.[0-9]+\.[0-9]+\.[0-9]+$' |
  grep -vE '^10\.[0-9]+\.[0-9]+\.[0-9]+$'
}
