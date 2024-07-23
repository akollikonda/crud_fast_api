#!/bin/bash

# Create main project directory
mkdir fastapi-project
cd fastapi-project

# Create app directory and its subdirectories
mkdir -p app/routers
mkdir tests

# Create Python files
touch app/__init__.py
touch app/main.py
touch app/models.py
touch app/schemas.py
touch app/database.py
touch app/routers/__init__.py
touch app/routers/items.py
touch tests/__init__.py
touch tests/test_main.py

# Create other necessary files
touch .env
touch .gitignore
touch requirements.txt
touch README.md
touch Dockerfile
touch docker-compose.yml

# Add initial content to main.py
cat << EOF > app/main.py
from fastapi import FastAPI
from .routers import items

app = FastAPI()

app.include_router(items.router)

@app.get("/")
def read_root():
    return {"Hello": "World"}
EOF

# Add initial content to items.py
cat << EOF > app/routers/items.py
from fastapi import APIRouter

router = APIRouter()

@router.get("/items/")
def read_items():
    return [{"name": "Item 1"}, {"name": "Item 2"}]
EOF

# Add content to requirements.txt
cat << EOF > requirements.txt
fastapi
uvicorn
sqlalchemy
EOF

# Add content to .gitignore
cat << EOF > .gitignore
venv/
__pycache__/
.env
*.pyc
*.pyo
*.pyd
.Python
env/
pip-log.txt
pip-delete-this-directory.txt
.tox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.log
.git
.mypy_cache
.pytest_cache
.hypothesis
EOF

# Add content to Dockerfile
cat << EOF > Dockerfile
FROM python:3.9

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
EOF

# Add content to docker-compose.yml
cat << EOF > docker-compose.yml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "8000:8000"
    volumes:
      - .:/app
    environment:
      - DATABASE_URL=sqlite:///./test.db
EOF

echo "FastAPI project structure created successfully!"