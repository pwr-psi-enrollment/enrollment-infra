#!/usr/bin/env bash
set -e

WD=$(pwd)

cd ~/Documents/source/pwr/enrollment-backend
mvn clean install -DskipTests
rsync -avz --progress target/enrollment-backend-0.0.1-SNAPSHOT-spring-boot.jar ~/Documents/source/pwr/enrollment-infra/enrollment-service/enrollment-service.jar

cd ~/Documents/source/pwr/mock-service
mvn clean install -DskipTests
rsync -avz --progress target/mock-service-0.0.1-SNAPSHOT-spring-boot.jar ~/Documents/source/pwr/enrollment-infra/mock-service/mock-service.jar
rsync -avz --progress -r data ~/Documents/source/pwr/enrollment-infra/mock-service/.

cd $WD

zip -r deployment.zip assets enrollment-service mock-service nginx docker-compose.yml

scp -i ~/Documents/y700-pair.pem deployment.zip ec2-user@3.10.51.120:
scp -i ~/Documents/y700-pair.pem install.sh ec2-user@3.10.51.120:

rm deployment.zip
