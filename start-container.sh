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
        -p $port:$port  --gpus device=1 \
        nordar/skull-strip-pipeline:2.12.0 \
        bash -c 'export PATH=$PATH:/.local/bin; jupyter notebook --no-browser --ip=0.0.0.0 --port='"$port"' --notebook-dir /home/dari --NotebookApp.token=ADD-YOUR-JUPYTER-TOKEN-HERE'

