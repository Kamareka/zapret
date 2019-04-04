#!/bin/sh
# create ipset from resolved ip's

SCRIPT=$(readlink -f $0)
EXEDIR=$(dirname $SCRIPT)
IPSET_OPT="hashsize 131072 maxelem 524288"
IPSET_OPT6="family inet6 hashsize 131072 maxelem 524288"
. "$EXEDIR/def.sh"

create_ipset()
{
ipset flush $2 2>/dev/null || ipset create $2 $1 $IPSET_OPT
for f in "$3" "$4"
do
 [ -f "$f" ] && {
  echo Adding to ipset $2 \($1\) : $f
  if [ -f "$ZIPLIST_EXCLUDE" ] ; then
   grep -vxFf $ZIPLIST_EXCLUDE "$f" | sort -u | sed -nre "s/^.+$/add $2 &/p" | ipset -! restore
  else
   sort -u "$f" | sed -nre "s/^.+$/add $2 &/p" | ipset -! restore
  fi
 }
done
return 0
}
create_ipset6()
{
ipset flush $2 2>/dev/null || ipset create $2 $1 $IPSET_OPT6
for f in "$3" "$4"
do
 [ -f "$f" ] && {
  echo Adding to ipset $2 \($1\) : $f
  sort -u "$f" | sed -nre "s/^.+$/add $2 &/p" | ipset -! restore
 }
done
return 0
}
create_ipset6 hash:ip $ZIPSET6 $ZIPLIST6 $ZIPLIST_USER6
create_ipset hash:ip $ZIPSET $ZIPLIST $ZIPLIST_USER
create_ipset hash:ip $ZIPSET_IPBAN $ZIPLIST_IPBAN $ZIPLIST_USER_IPBAN
ipset save zapret -f /opt/zapret/ipset/zapret.ipset
ipset save zapret6 -f /opt/zapret/ipset/zapret6.ipset
