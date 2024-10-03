$SOURCE_IMAGE_VERSION="2.17.0"
$BUILD_VERISON="02"
$TAG="${SOURCE_IMAGE_VERSION}-${BUILD_VERISON}"

docker build --pull --rm -f "DOCKERFILE" -t skull-strip-pipeline:$TAG "."

docker tag skull-strip-pipeline:$TAG nordar/skull-strip-pipeline:$TAG

docker push nordar/skull-strip-pipeline:$TAG

docker tag skull-strip-pipeline:$TAG nordar/skull-strip-pipeline:latest
docker push nordar/skull-strip-pipeline:latest
