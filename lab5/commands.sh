sudo docker build . -t new
sudo docker run -p 80:80 new python3 /code/manage.py runserver 0.0.0.0:80
