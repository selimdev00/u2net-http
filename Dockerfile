# FROM nvcr.io/nvidia/pytorch:19.12-py3
FROM pytorch/pytorch:0.4.1-cuda9-cudnn7-runtime

RUN apt-get update && apt-get install -y \
	python3-pip software-properties-common wget && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install production dependencies.
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Set default port.
ENV PORT 80

# Run the web service using gunicorn.
CMD exec gunicorn --bind :$PORT --workers 1 main:app
