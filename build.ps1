docker build --pull --rm -f "DOCKERFILE" -t skull-strip-pipeline:2.12.0 "."

docker tag skull-strip-pipeline:2.12.0 nordar/skull-strip-pipeline:2.12.0
docker tag skull-strip-pipeline:2.12.0 nordar/skull-strip-pipeline:latest

docker push nordar/skull-strip-pipeline:2.12.0
docker push nordar/skull-strip-pipeline:latest
