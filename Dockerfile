FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/wakaleo/game-of-life.git

FROM maven:3.5-jdk-8-alpine as build 
WORKDIR /app
COPY --from=clone /app/game-of-life /app
RUN mvn install

FROM tomcat:8-jre8-alpine
WORKDIR /app
COPY --from=build /app/gameoflife-web/target/gameoflife.war /usr/local/tomcat/webapps/gol.war
CMD ["catalina.sh", "run"]
