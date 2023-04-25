#!/bin/bash
NB_USER=$(whoami)
echo "[NOTE]: Current user: $NB_USER"
echo "[ACTION]: Creating local 'work' directory"
mkdir -pv work
echo "[NOTE]: Notebook work is saved under local directory $PWD/work"
echo "[ACTION]: Spin up jupyter/tensorflow-notebook container"
NB_USER=$(whoami)
docker run -td --name notebook \
	       --user root \
	       -e NB_USER="$NB_USER" \
	       -e CHOWN_HOME=yes \
	       -p 8888:8888 \
	       -v $(pwd)/work:/home/$NB_USER/work jupyter/tensorflow-notebook
sleep 2
RUNTIME_JSON=$(docker exec -i notebook ls /home/$NB_USER/.local/share/jupyter/runtime/ | grep json)
URL=$(docker exec -i notebook cat /home/$NB_USER/.local/share/jupyter/runtime/$RUNTIME_JSON | grep token | awk -F '"' '{print "http://localhost:8888/lab?token="$(NF-1)}')
echo "[NOTE]: Bookmark acccess URL: $URL"
echo "[ACTION]: Opening access URL: $URL"
python3 -m webbrowser $URL
