# Skull Stripping Pipeline
The docker image, currently hosted on [docker hub](https://hub.docker.com/r/nordar/skull-strip-pipeline/tags), facilitates a skull stripping pipeline in the following projects:  
* ...

## About the Image
This Image is based on [the official TensorFlow image: tensorflow/tensorflow:2.17.0-gpu-jupyter](https://hub.docker.com/r/tensorflow/tensorflow). Our main intention is to have `CUDA/GPU` support on the one hand and preconfigured `Jupyter` support on the other hand.

Additionally to facilitate the skull stripping the following utilities and their respective versions are installed on top:  
* [HD-BET](https://github.com/MIC-DKFZ/HD-BET) (current)
* [elastix](https://github.com/SuperElastix/elastix) (5.0.0)
* [ANTs]( https://github.com/ANTsX/ANTs) (2.1.0)

Python packages:
* SimpleITK
* nibabel
* totalsegmentor
* dcm2niix

## Building a New Version
A new version of the image can be built by running `build.ps1` on Windows or an equivalent bash script on any Unix OS.

To upgrade to a new base image take the following steps:
* Check out which [new tensorflow](https://hub.docker.com/r/tensorflow/tensorflow/tags) image fulfills your requirements.
    * In the `build.ps1`: change the source image version variable and increment or decrement the build version accordingly.
    * In the `DOCKERFILE`: change the source image to the one selected
* In a local terminal, run the source image with `docker run --rm <tensorflows-new-image> /bin/bash`
* In this interactive terminal recreate all `RUN` steps and if the command needs modification copy the modifications to the `DOCKERFILE`.
* When the target state of the running container is reached you can close the container.
* Run the build script `build.ps1` or its UNIX equivalent.
    * Make sure to change the target docker repository from `nordar` to your own repository.
    * [(maybe you need to log into docker before you can push)](https://docs.docker.com/reference/cli/docker/login/)