`docker build -t golang-demo .`


`docker run --name=golang-http-demo -p 8082:8080 -itd golang-demo`


`curl localhost:8082`