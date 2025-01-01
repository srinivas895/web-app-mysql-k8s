FROM mysql:8.0

# Copy the initialization SQL script into the container's initialization directory
COPY init.sql /docker-entrypoint-initdb.d/

# Optionally, expose the MySQL port
EXPOSE 3306
