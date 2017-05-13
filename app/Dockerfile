FROM python:3.6-alpine
ENV DJANGO_PRODUCTION=true
EXPOSE 8000
ADD start.sh /start.sh
ADD f_test /f_test
WORKDIR /f_test
RUN pip install -r requirements.txt
RUN python manage.py migrate
ENTRYPOINT /start.sh
