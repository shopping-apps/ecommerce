FROM python:3.10-slim-buster

RUN apt update && apt install -y build-essential gettext python3-dev

ENV PYTHONUNBUFFERED=1

RUN mkdir /usr/app
WORKDIR /usr/app
COPY . /usr/app

RUN pip install django==3.0.5
RUN pip install django-widget-tweaks
RUN pip install xhtml2pdf

RUN python manage.py makemigrations
RUN python manage.py migrate
RUN python manage.py shell -c "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'changeme')"

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]