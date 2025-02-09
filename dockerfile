# Use official Python image as base
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Copy your code into the container
COPY . .

# Install required dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Run Django migrations before starting the server (helpful for setting up the database)
CMD ["python", "manage.py", "migrate", "&&", "python", "manage.py", "runserver", "0.0.0.0:8000"]
