container_name="com.zgardner.msa.zookeeper.di"
docker_registry_path="registry.docker.msa.zgardner.com:5000"
tag_name="$docker_registry_path/$container_name:latest"

echo "Building image $tag_name..."
docker build -t $tag_name .

echo "Pushing to registry..."
docker push $tag_name
