
FROM maven:3.5-jdk-8

RUN mkdir -p /deploy/application

VOLUME ["/deploy/application"]

WORKDIR /deploy/application

ADD . .

COPY --from=build-image /deploy/application/target/ROOT.war /usr/local/tomcat/webapps/

ENTRYPOINT ["mvn","clean","package"]

