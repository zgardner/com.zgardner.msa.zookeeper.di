container_name="com.zgardner.msa.zookeeper.di"
docker_registry_path="registry.docker.msa.zgardner.com:5000"
tag_name="$docker_registry_path/$container_name:latest"
host_api_port="2181"
container_api_port="2181"
zookeeper_node_hostname="zookeeper.msa.zgardner.com"
zookeeper_node_ip="192.168.1.68"
volume_lib_container_path="/var/lib/zookeeper"
volume_lib_host_path="$(pwd)$volume_lib_container_path"
volume_log_container_path="/var/log/zookeeper"
volume_log_host_path="$(pwd)$volume_log_container_path"
environment_service_name_variable="SERVICE_NAME"
environment_service_name_value="COM_ZGARDNER_MSA_ZOOKEEPER"
environment_container_name_variable="CONTAINER_NAME"
environment_container_name_value="${environment_service_name_value}_CONTAINER"
environment_service_instances_variable="${environment_service_name_value}_INSTANCES"
environment_service_instances_value="$environment_container_name_value"
environment_zookeeper_server_ids_variable="ZOOKEEPER_SERVER_IDS"
environment_zookeeper_server_ids_value="$environment_container_name_value:1"
environment_host_variable="${environment_service_name_value}_${environment_container_name_value}_HOST"
environment_host_value="$zookeeper_node_hostname"
environment_client_port_variable="${environment_service_name_value}_${environment_container_name_value}_CLIENT_PORT"
environment_client_port_value="2181"
environment_peer_port_variable="${environment_service_name_value}_${environment_container_name_value}_PEER_PORT"
environment_peer_port_value="2888"
environment_leader_election_port_variable="${environment_service_name_value}_${environment_container_name_value}_LEADER_ELECTION_PORT"
environment_leader_election_port_value="3888"
environment_max_snapshot_retain_count_variable="MAX_SNAPSHOT_RETAIN_COUNT"
environment_max_snapshot_retain_count_value="10"
environment_purge_interval_variable="PURGE_INTERVAL"
environment_purge_interval_value="24"

#echo "Pulling latest tag $tag_name..."
#docker pull $tag_name

echo "Killing container $container_name..."
docker kill $container_name

echo "Removing container $container_name..."
docker rm $container_name

echo "Starting contaner $container_name..."
docker run -d --name $container_name -p $host_api_port:$container_api_port --add-host="$zookeeper_node_hostname:$zookeeper_node_ip" -v "$volume_lib_host_path:$volume_lib_container_path" -v "$volume_log_host_path:$volume_log_container_path" -e "$environment_service_name_variable=$environment_service_name_value" -e "$environment_container_name_variable=$environment_container_name_value" -e "$environment_service_instances_variable=$environment_service_instances_value" -e "$environment_zookeeper_server_ids_variable=$environment_zookeeper_server_ids_value" -e "$environment_host_variable=$environment_host_value" -e "$environment_client_port_variable=$environment_client_port_value" -e "$environment_peer_port_variable=$environment_peer_port_value" -e "$environment_leader_election_port_variable=$environment_leader_election_port_value" -e "$environment_max_snapshot_retain_count_variable=$environment_max_snapshot_retain_count_value" -e "$environment_purge_interval_variable=$environment_purge_interval_value" $tag_name
