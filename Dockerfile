FROM jetty:11-jdk17

# Copy the WAR file (named spring-petclinic.war) into Jetty
COPY target/spring-petclinic.war /var/lib/jetty/webapps/ROOT.war

EXPOSE 8080
