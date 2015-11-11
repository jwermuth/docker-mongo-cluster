pipework also great, but If you can use hostname other than ip then you can try this script

#!/bin/bash
# This function will list all ip of running containers
function listip {
    for vm in `docker ps|tail -n +2|awk '{print $NF}'`; 
        do
            ip=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' $vm`;
            echo "$ip  $vm";
        done    
}

# This function will copy hosts file to all running container /etc/hosts
function updateip {
        for vm in `docker ps|tail -n +2|awk '{print $NF}'`;
                do
                        echo "copy hosts file to  $vm";
                        docker exec -i $vm sh -c 'cat > /etc/hosts' < /tmp/hosts
                done
}
listip
#listip > /tmp/hosts
#updateip
