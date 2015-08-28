container_name="com.zgardner.msa.zookeeper.di"
docker_registry_path="registry.docker.msa.zgardner.com:5000"
tag_name="$docker_registry_path/$container_name:latest"
host_api_port="2181"
container_api_port="2181"
volume_lib_container_path="/var/lib/zookeeper"
volume_lib_host_path="$(pwd)$volume_lib_container_path"
volume_log_container_path="/var/log/zookeeper"
volume_log_host_path="$(pwd)$volume_log_container_path"
environment_service_name_variable="SERVICE_NAME"
environment_service_name_value="$container_name"

echo "Pulling latest tag $tag_name..."
docker pull $tag_name

echo "Killing container $container_name..."
docker kill $container_name

echo "Removing container $container_name..."
docker rm $container_name

echo "Starting contaner $container_name..."
docker run -d --name $container_name -p $host_api_port:$container_api_port -v "$volume_lib_host_path:$volume_lib_container_path" -v "$volume_log_host_path:$volume_log_container_path" -e "$environment_service_name_variable:$environment_service_name_value" $tag_name
