# Elm Workshop

## Setup - the docker way

- Clone this repository - this is where we'll be doing our work

- Ensure docker is installed and configured properly

- Pull the docker image

        docker pull leonardoborges/elmworkshop
    
- Run the container    

        docker run --net=host -v $PWD:/elm-workshop -w /elm-docs leonardoborges/elmworkshop
  
  
This will setup a new docker container exposing two ports: 3000 and 8000

`http://$CONTAINER_IP:8000/` - Has elm-reactor running with a sample Hello.elm file. Click on it and try it out
`http://$CONTAINER_IP:3000/` - Has offline docs for Elm's core libraries



Theoretically once you have this setup, you shouldn't need internet connection anymore. Let me know if you find issues.



### Mac and Windows users

You need to to setup [boot2docker](http://boot2docker.io/) before you can setup docker.

Additionally, under windows and mac environments, the container has limited access to your filesystem so make sure to clone this project somewhere in your home directory.

## Setup - non-docker way


Mac and Windows have binaries [here](http://elm-lang.org/Install.elm). For Linux you will need to build from source so I highly recommend using the docker setup described above.

Regardless of operating system however, the docker image also includes offline documentation which is desired for a workshop as internet access is limited.

If you choose this path, be aware you might not be able to access the docs during the workshop, unless you can use some form of tethering.