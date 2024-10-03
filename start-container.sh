#!/bin/bash
usedPorts=$(netstat -latn --inet | awk '{print $4}' | awk -F : '{print $2}' | sort -u)
for port in {8988..8999}; do
  echo "trying port $port"
  echo "$usedPorts" | grep -q "^$port$" || break
done
echo "starting container with jupyter notebook on port $port"

docker run -d \
        --name img-pipeline-dari \
        -u "$(id -u)":"$(id -g)" \
        -v /home/dari:/home/dari \
        -v /home:/host-homes \
        -v /home:/tf/notebooks \
        -v /etc/group:/etc/group:ro \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/shadow:/etc/shadow:ro \
        -e JUPYTER_TOKEN="eee"\
        -e JUPYTER_ENABLE_LAB="yes" \
        -e NB_UID="$(id -u)" \
        -e NB_GID="$(id -g)" \
        -e JUPYTER_PORT="$port" \
        -p "$port":"$port" \
        --gpus device=0 --workdir=/home/dari \
        nordar/skull-strip-pipeline:2.16.2-01


# windows
docker run -ti `
        --name skull-strip-gpu `
        -p 1234:1234 `
        skull-strip-pipeline:2.12.0-01 `
        bash -c 'export PATH=$PATH:/.local/bin; jupyter notebook --allow-root --no-browser --ip=0.0.0.0 --port=1234 --NotebookApp.token=eee'
