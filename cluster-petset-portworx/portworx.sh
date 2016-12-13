ssh -i ~/.ssh/kube_aws_rsa -o StrictHostKeyChecking=no ubuntu@$1 "sudo sed -i 's/MountFlags/#MountFlags/g' /lib/systemd/system/docker.service; \
   sudo systemctl daemon-reload; \
   sudo systemctl restart docker; \
   sudo docker run --restart=always --name px -d --net=host \
   --privileged=true \
   -v /run/docker/plugins:/run/docker/plugins \
   -v /var/lib/osd:/var/lib/osd:shared \
   -v /dev:/dev \
   -v /etc/pwx:/etc/pwx \
   -v /opt/pwx/bin:/export_bin \
   -v /usr/libexec/kubernetes/kubelet-plugins/volume/exec/px~flexvolume:/export_flexvolume:shared \
   -v /var/run/docker.sock:/var/run/docker.sock \
   -v /var/cores:/var/cores \
   -v /var/lib/kubelet:/var/lib/kubelet:shared \
   --ipc=host \
   portworx/px-enterprise -k etcd:http://etcd-us-east-1b.portworx.com:4001 -c $2 -a -f"
