Build and Run the Docker Image
 docker build -t my-nginx-php-app 
Run the Docker Container:
 docker run -d -p 80:80 --name my-app my-nginx-php-app

