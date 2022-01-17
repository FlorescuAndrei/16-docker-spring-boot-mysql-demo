FROM openjdk:11

COPY target/14-thymeleaf-demo-0.0.1-SNAPSHOT.jar 14-thymeleaf-demo-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","14-thymeleaf-demo-0.0.1-SNAPSHOT.jar"]