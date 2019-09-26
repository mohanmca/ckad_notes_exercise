# Running elasticsearch using kubernetes

* Default command to run ElasticSearch was failing, and process was killed
* dmesg -T| grep -E -i -B100 'killed process' (helped to find the root cause)
* It was out of memory
* minikube ssh
  * sudo sysctl -w vm.max_map_count=262144 

* https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/admin/resource/memory-defaults.yaml
* Update limits to 1512 as default memory in LimitRange and apply to default namesapce
* Run the ElasticSearch
  * k run el --image=elasticsearch:6.8.3 --tty --restart=Never --rm  -it -- sh
  * k run el --image=elasticsearch:6.8.3 --restart=Never 
  * k run el --image=elasticsearch:6.8.3 --restart=Never --port=6200
  * k expose pods el
  * bb wget -qO-  bb wget -qO- http://ELS_POD_IP:9200/_search
  * bb wget -qO- http://MINKUBE_NODE_IP:32200/_search?



# Container path location
  * login to el container
  * /usr/local/bin/docker-entrypoint.sh
  * /etc/share/elasticsearch/bin/

