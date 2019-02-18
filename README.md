[Docker](https://hub.docker.com/r/cadizm/ai-env/) image and compose files for containerized AI development.

### Usage

There are 2 intended use cases:


#### Option 1

1. Pull the image: `$ docker pull cadizm/ai-env`
2. Copy `docker-compose.yml` to your development project
3. Run the container: `$ docker-compose run --rm --workdir=/src ai-env`
4. Compile and run your project source


#### Option 2

1. Pull the image: `$ docker pull cadizm/ai-env`
2. `cd` to your development project
3. Run the container: `docker run --rm -it --workdir /src --mount src=$(pwd),target=/src,type=bind cadizm/ai-env`
4. Compile and run your project source
