FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

COPY . /app/

# Agar staticdan foydalanmasangiz, quyidagi qatorni olib tashlang:
RUN python manage.py collectstatic --noinput || true

EXPOSE 8000

CMD ["gunicorn", "crm_project.wsgi:application", "--bind", "0.0.0.0:8000"]