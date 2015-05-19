# Elm Workshop

## Setup - the easy way

- Ensure docker is installed and configured properly

- Pull the docker image

    docker pull leonardoborges/elmworkshop
    
- Run the container    

  docker run --net=host -v $PWD:/elm-workshop -w /elm-docs leonardoborges/elmworkshop
  
  
This will setup a new docker container exposing two ports: 3000 and 8000


`http://$CONTAINER_IP:8000/` - Has elm-reactor running with a sample Hello.elm file. Click on it and try it out
`http://$CONTAINER_IP:3000/` - Has offline docs for Elm's core libraries



Theoretically once you have this setup, you shouldn't need internet connection anymore. Let me know if you find issues.
