for ((i=1; i <= 7; i++))
do
    #echo $i    
    #echo $(($i+4))
    echo "sudo mdadm --manage /dev/md$i --add /dev/sdc$(($i+4))"
    sudo mdadm --manage /dev/md$i --add /dev/sdc$(($i+4))
done
