# Use Jetty with JDK 17
FROM jetty:11-jdk17

# Set WAR file name
ENV WAR_FILE petclinic.war

# Copy WAR into Jetty's webapps as ROOT.war
COPY target/${WAR_FILE} /var/lib/jetty/webapps/ROOT.war

# Expose Jetty default port
EXPOSE 8080
