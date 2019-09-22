
FROM maven:3.5-jdk-8

RUN mkdir -p /deploy/application

VOLUME ["/deploy/application"]

WORKDIR /deploy/application

ADD . .

COPY  /deploy/application/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war

ENTRYPOINT ["mvn","clean","package"]

