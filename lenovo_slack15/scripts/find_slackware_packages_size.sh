#/bin/bash

TMP=$(mktemp)

COUNT=0
for PKG in /var/log/packages/*; do
 SIZE_PKG=$(sed -rn 's/^UNCOMPRESSED PACKAGE SIZE:\s+(\S+)\s*$/\1/p' $PKG)
 M=1
 if [ "${SIZE_PKG%K}" != "$SIZE_PKG" ]; then
  SIZE_PKG="${SIZE_PKG%K}"
  M=1024
 elif [ "${SIZE_PKG%M}" != "$SIZE_PKG" ]; then
  SIZE_PKG="${SIZE_PKG%M}"
  M=1048576
 fi
 if [ "${SIZE_PKG%.*}" != "$SIZE_PKG" ]; then
  CA=0
  if [ "${SIZE_PKG%.[56789]*}" != "$SIZE_PKG" ]; then
   CA=1
  fi
  SIZE_PKG="${SIZE_PKG%.*}"
  (( SIZE_PKG += CA ))
 fi
 (( SIZE_PKG *= M ))
 DESCRIPTION=$(sed -rn '
  /^PACKAGE DESCRIPTION:$/{
   n
   p
  }' $PKG)

 echo -e "$SIZE_PKG\t${PKG##*/}\t$DESCRIPTION"
 echo -e "$SIZE_PKG\t${PKG##*/}\t$DESCRIPTION" >>$TMP
 (( COUNT++ ))
 if (( COUNT > 10 )); then
  #break;
  :
 fi
done

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

sort -n $TMP


rm --force $TMP

