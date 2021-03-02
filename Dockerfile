FROM tomcat:8.0-alpine
LABEL maintainer "Ankita Kumari"
Add target/*.war usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh","run"]
