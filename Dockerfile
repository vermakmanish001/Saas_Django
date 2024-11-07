ARG PYTHON_VERSION=3.12-slim-bullseye
FROM python:${PYTHON_VERSION}

# Set up the virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip
RUN pip install --upgrade pip

# Install OS dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev libjpeg-dev libcairo2 gcc \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /code

# Copy requirements and install Python dependencies
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

# Copy project code
COPY ./src /code

# Command to run Django development server (replace with gunicorn for production)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
