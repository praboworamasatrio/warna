FROM maven:3.5-jdk-8

RUN mkdir -p /usr/local/tomcat/webapps

VOLUME ["/usr/local/tomcat/webapps"]

WORKDIR /usr/local/tomcat/webapps

ADD target/ROOT.war ROOT.war

ENTRYPOINT ["mvn","clean","package"]


