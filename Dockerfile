# Use official Tomcat base image
FROM tomcat:9.0-jre21

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your built WAR into Tomcat as ROOT
COPY target/system.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
