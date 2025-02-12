# Use official Python image as base
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Copy your code into the container
COPY . .

# Install required system libraries and Python dependencies in one step
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    curl \
    gnupg2 \
    libpq-dev \
    && apt-get clean \
    && pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt \
    && pip install psycopg2  # Install psycopg2 (if not included in requirements.txt)

# Set the environment variable for the Django settings module
ENV DJANGO_SETTINGS_MODULE=myproject.settings

# Expose the port for the Django development server
EXPOSE 8000

# Run Django migrations before starting the server (helpful for setting up the database)
CMD ["python", "manage.py", "migrate", "&&", "python", "manage.py", "runserver", "0.0.0.0:8000"]
