docker run -itd \
--restart=always \
-v $(pwd):/app/Vmq \
-p 8005:8005 \
--name vmq \
openjdk:8-jdk-alpine java -jar /app/Vmq/target/mq-0.0.1-SNAPSHOT.war --server.port=8005
