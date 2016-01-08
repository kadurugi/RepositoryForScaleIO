################
#### set arguments devices name
#### [e.g] parted.sh /dev/sdb 
################
#!/bin/sh
dev=$1

#### get disksize and partition count
disksize=$(parted $dev print free | grep /dev.*GB  | sed "s/GB//" | awk '{print $3 ;}')
partcount=$(expr $disksize / 100)
startsize=1
endsize=$(expr $startsize + 100)

#### delete existing partition
for i in `seq 1 $partcount`
 do
   /usr/sbin/parted $dev -s rm $i
 done

#### create new 100GiB partition
/usr/sbin/parted $dev -s mklabel gpt

for i in `seq 1 $partcount`
 do
  /usr/sbin/parted $dev -s mkpart primary $startsize'GiB' $endsize'GiB'
  startsize=`expr $startsize + 100`
  endsize=`expr $startsize + 100`
 done

/usr/sbin/parted $dev -s mkpart primary $startsize'GiB' 100%


