# jupyter-in-docker

## How to run
`sh setup.sh`

## How it works
- Find current user, create local work directory under $PWD.
- Spin up a local jupyter/tensorflow-notebook container by specifying notebook user to the current user and mount the local work directory to the notebook container.
- Fetch access URL, and open the URL in a local browser.
