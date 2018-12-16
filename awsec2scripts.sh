#!/bin/bash

# https://medium.com/techkylabs/django-deployment-on-linux-ubuntu-16-04-with-postgresql-nginx-ssl-e6504a02f224

sudo apt-get update && apt-get upgrade -y
sudo apt-get install python3-dev python3-dev python3-virtualenv libpq-dev \
    postgresql postgresql-contrib nginx git
# Don't worry about database credentials. This will be changed
# this is bad
sudo su - postgres
psql -c "CREATE USER djangoawsuser WITH PASSWORD 'djangoawspassword';"
psql -c "ALTER ROLE djangoawsuser SET CLIENT_ENCODING TO 'utf8';"
psql -c "ALTER ROLE djangoawsuser SET DEFAULT_TRANSACTION_ISOLATION TO 'read committed';"
psql -c "ALTER ROLE djangoawsuser SET TIMEZONE TO 'UTC';"
psql -c "CREATE DATABASE djangoaws WITH OWNER=djangoawsuser;"
psql -c "GRANT ALL ON DATABASE djangoaws to djangoawsuser;"
logout
git clone https://github.com/sagar-spkt/DjangoAWS.git
cd DjangoAWS
aws s3 cp s3://djangoaws/.env ./.env
virtualvenv venv
source venv/bin/activate
pip install -r requirements.txt
python manage.py migrate
python manage.py collectstatic
echo "from django.contrib.auth.models import User; User.objects.create_superuser('sagar', 'sagar@example.com', 'sagar12345')" | python manage.py shell
deactivate
sudo mkdir -p /etc/systemd/system/ && cp gunicorn.service /etc/systemd/system/
sudo systemctl start gunicorn
sudo systemctl enable gunicorn
sudo mkdir -p /etc/nginx/sites-available/ && cp nginxserver /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/nginxserver /etc/nginx/sites-enabled
sudo nginx -t
sudo service nginx restart
sudo ufw allow 'Nginx Full'

