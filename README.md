# Kubernetes in a box - Three nodes deployment + Scaling

Deploy kubernetes on the fly, the project creates a ``master node and two minions nodes``,
it uses **Vagrant** with **KVM** as infrastecture provider (IaaS) and **Ansible** as configuration manager
to automatically have a ready and functional **kubernetes cluster** in less than 15 minutes.

As an extra the entire **kubernetes cluster** can be scalable if wished, the project has a **k8s-scale** folder
to **add a new minion** to the existing cluster.

## 1. Pre-requisites

* Localhost machine with Linux distribution
* KVM
* Vagrant 1.8.1 or higher
* Vagrant libvirt plugin for KVM
* Ansible 2.2.1 or higher

### 1.1. Cluster service versions working.

  * kubernetes: 1.5.2
  * etcd: 3.2.15
  * flanneld: 0.7.1
  * docker: 1.13.1

## 2. Prepare your localhost environment

The first thing is check that you localhost support virtualization, just type 
``egrep -c '(vmx|svm)' /proc/cpuinfo`` if the result is ``0``, your localhost does not support it, 
in other case ``> 0``, means you locahost support virtualization, but also must be ensured it is enable 
in the BIOS. Once it is assured procced to install ``kvm`` (https://www.linux-kvm.org/page/Downloads).

Next to complete the environment and reproduce the ``kubernetes cluster``, 
with the use of ``Vagrant`` just install it (https://www.vagrantup.com/) on your localhost and must be 
installed ``Ansible`` also (http://docs.ansible.com/ansible/latest/intro_installation.html).

In the other hand to use ``kvm`` to setup kubernetes cluster nodes, must be installed the ``vagrant libvirt provider``,
it is a ``plugin`` for ``vagrant`` to use with ``libvirt`` API to manage ``kvm`` as infraestructure provider.
(https://github.com/vagrant-libvirt/vagrant-libvirt#installation) 

Finally we need a ``Public RSA Key`` to inject in the ``Kubernetes Cluster`` nodes, therefore if you have already 
one fine, it is going to be used later, otherwise proceed to ``Generate SSH Keys`` in your localhost
(https://www.cyberciti.biz/faq/linux-unix-generating-ssh-keys/)

## 3. Setup your kubernetes cluster

* In the localhost just clone the repository   
   ``git clone https://github.com/pahharo/kubernetes_and_lora_deployment.git``

* Go inside the folder k8s-cluster  
   ``cd k8s-cluster``

* Set your ``Publis RSA Key`` in the script ``scripts/prepare_cluster.py``, generally it is located in ~/.ssh/id_rsa.pub

* Start up the ``Kubernetes Cluster``  
   ``vagrant up --provider libvirt``

That's all ...

## 4. Check your Kubernetes Cluster

Now check the entire cluster with the next tips

* Go to master host and check the nodes
  ``ssh root@master``
  ``kubectl get nodes``

  it must show the two minions nodes ready and working:  
  ``[root@master services-manu]# kubectl get nodes``  
    ``NAME       STATUS    AGE``  
    ``minion-1   Ready     112d``  
    ``minion-2   Ready     112d``

  Check the cluster-info:

  ``kubectl cluster-info``  

The above command must be show someting similar to:  
   
>Kubernetes master is running at http://localhost:8080   
>KubeDNS is running at http://localhost:8080/api/v1/proxy/namespaces/kube-system/services/kube-dns

## 5. Scale the existing Kubernetes Cluster

Follow the next steps to scale up your entire cluster

* Go inside the folder k8s-scale   
  ``cd k8s-cluster/k8s-scale/``   

* Start up the new Minion node to add in the ``Kubernetes Cluster``  
   ``vagrant up --provider libvirt``  

* Go to master node and check minion nodes (Must be appears three nodes)  
  ``vagrant ssh master``  
  ``kubectl get nodes --server=http://master.com:8080``  

## 6. Deploy lora server in kubernetes cluster

* Deploy lora server 

  Go to kubernetes_files folder and execute the next command:

     ``kubectl create -f deployments/full-lora-deployment.yaml -s http://10.10.10.51:8080``  
     ``kubectl create -f services/full-lora-with-all-ports.yml -s http://10.10.10.51:8080``
* Check the deployment

  ``kubectl get deployments``

* Modify iptables to forward traffic in minion-1 and minion-2

  ``iptables -P FORWARD ACCEPT``

* Check that lora server is running

  You can check the port assigned to our lora-app-server mapped to the 8080 port executing:
  ``kubectl get services``
  It must be a service called 'lora-full-services' which shows the mapped ports, so once we have it, go to your browser and look for:

    https://<minion_ip>:<mapped_port>

  The minion-ip could be the minion-1 ip or the minion-2 ip, and the mapped port must be the one mapped to the 8080.

## 7. Script to update /etc/hosts with active minion ip.
 
  In case that a minion would be down, we can execute the connectivity_script.sh in background, that will update the /etc/hosts file with the ip of the active minion associated to the name "lora-server". Then, if we want to do a request, we can send the request as:
    https://lora-server:<mapped_port>

## 8.Credits

Thanks also to my partners @Noel_illo (Noel Ruiz Lopez) and @joedval (Jorge Valderrama) for your help :)
