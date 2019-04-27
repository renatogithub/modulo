#!bin/bash
echo "################## Construyendo imagen docker ##################"
docker build -t api-seguridad .
echo "################## Tag de la imagen docker ##################"
docker tag api-seguridad:latest 741954040391.dkr.ecr.us-east-1.amazonaws.com/api-seguridad:latest
echo "################## Subiendo a AWS ECS repository ##################"
$(${AWS_BIN} ecr get-login --no-include-email --region us-east-1)
docker push 741954040391.dkr.ecr.us-east-1.amazonaws.com/api-seguridad:latest
echo "################## Forzando la actualizacion SERVICE ECS ##################"
${AWS_BIN} ecs update-service --cluster CursoAWS --service seguridad --force-new-deployment
