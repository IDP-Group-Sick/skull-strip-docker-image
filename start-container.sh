usedPorts=$(netstat -latn --inet | awk '{print $4}' | awk -F : '{print $2}' | sort -u)
for port in {8888..9999}; do
  echo "trying port $port"
  echo "$usedPorts" | grep -q "^$port$" || break
done
echo "starting container with jupyter notebook on port $port"


docker run -ti -d \
        --name skull-strip-gpu \
        -u $(id -u):$(id -g) \
        -v /home/dari:/home/dari \
        -v /home:/host-homes \
        -v "/etc/group:/etc/group:ro" \
        -v "/etc/passwd:/etc/passwd:ro" \
        -v "/etc/shadow:/etc/shadow:ro" \
        --workdir=/home/dari \
        -p $port:$port  --gpus device=0 \
        nordar/skull-strip-pipeline:2.12.0 \
        bash -c 'export PATH=$PATH:/.local/bin; jupyter notebook --no-browser --ip=0.0.0.0 --port='"$port"' --notebook-dir /home/dari --NotebookApp.token=eee'

# not mapped
docker run -ti \
        --name skull-strip-gpu \
        -p $port:$port \
        nordar/skull-strip-pipeline:2.12.0 \
        bash -c 'export PATH=$PATH:/.local/bin; jupyter notebook --allow-root --no-browser --ip=0.0.0.0 --port='"$port"' --NotebookApp.token=eee'

# windows
docker run -ti `
        --name skull-strip-gpu `
        -p 1234:1234 `
        skull-strip-pipeline:2.12.0-01 `
        bash -c 'export PATH=$PATH:/.local/bin; jupyter notebook --allow-root --no-browser --ip=0.0.0.0 --port=1234 --NotebookApp.token=eee'
