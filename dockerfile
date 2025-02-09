# Use official Python image as base
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Copy your code into the container
COPY . .

# Install required dependencies
RUN pip install --upgrade pip
# Install the dependencies from the requirements.txt file
RUN pip install --no-cache-dir -r requirements.txt

# Install ODBC Driver for SQL Server (necessary for django-mssql-backend)
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    curl \
    gnupg2 \
    unixodbc-dev \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/mssql-server-2017/debian/packages-mssql-2017.repo > /etc/apt/sources.list.d/mssql-server-2017.list \
    && apt-get update \
    && apt-get install -y msodbcsql17

# Install django-mssql-backend specifically
RUN pip install django-mssql-backend

# Set the environment variable for the Django settings module
ENV DJANGO_SETTINGS_MODULE=myproject.settings

# Expose the port for the Django development server
EXPOSE 8000

# Run Django migrations before starting the server (helpful for setting up the database)
CMD ["python", "manage.py", "migrate", "&&", "python", "manage.py", "runserver", "0.0.0.0:8000"]
