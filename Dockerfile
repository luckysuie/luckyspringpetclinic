# Use Jetty with JDK 17
FROM jetty:11-jdk17

# Set optional environment variable for WAR file name
ENV WAR_FILE petclinic.war

# Copy the WAR file to Jetty's webapps directory
COPY target/${WAR_FILE} /var/lib/jetty/webapps/ROOT.war

# Expose the default Jetty port
EXPOSE 8080
