FROM openjdk:11
COPY target/*.jar MediCure.jar
ENTRYPOINT ["java", "-jar", "MediCure.jar"]
