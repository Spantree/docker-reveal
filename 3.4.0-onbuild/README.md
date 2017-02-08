# Overview
This Dockerfile is a building block for creating reusable Reveal presentations that are self-contained and easily distributable.  The goals of this are two fold: 

* Provide an easy distribution platform for Reveal presentations (Cache runtime and build dependencies)
* Allow for rapid iteration of the slides themselves when in "hack" mode

## Example Usage
Build the base container or pull from public registry: 
```
docker build -t spantree/reveal:3.4.0-onbuild .
```

Build an actual slide deck leveraging base build: (ex. https://github.com/Spantree/elasticsearch-talk)
```
git clone https://github.com/Spantree/elasticsearch-talk ~/elasticsearch-talk
cd ~/elasticsearch-talk/slides
echo FROM spantree/reveal:3.4.0-onbuild > Dockerfile
docker build -t estalk .
```

**NOTE:** At this point, we have a local image tagged `estalk` that contains a set of all dependencies, slides, etc. that can simply be run! 

### Run the talk in presentation mode: 
Run the encapsulated presentation locally. 

```
docker run -it --rm -p 9000:9000 --name estalk estalk
```

### Run in development mode: 
Run the presentation locally with the slides mounted to allow for quick & iterative development. 

```
docker run -rm --it -p 9000:9000 -v $(pwd)/slides:/usr/src/slides/slides estalk
# Hack hack hack on slides
# Reload browser
# ... 
# profit
```

**NOTE:** Because of the `ONBUILD` directives, if there are actual changes you want to make to the dependencies (package.json or bower.json) or the build process itself (Gruntfile) you should `rebuild` the image to ensure you have a consistent and repeatable build!

## Requirements
The Dockerfile works by making several assumptions of the projects that will utilize it.  It utilizes the `ONBUILD` directive that is available to all Docker containers.  

As a consumer (ex. `FROM spantree/reveal:3.4.0-onbuild`), presentation developers simply need to follow a few conventions: 

### File Requirements
* `package.json` - Standard NPM formatted file with all the requirements defined
* `bower.json` - Front end dependencies to be pulled via Bower
* `.bowerrc` - Bower configuration file (build will fail if something is not present)

### Grunt Configuration 
The `ONBUILD` and `CMD` expect a few things from the Grunt configuration. 

Targets: 
* `build` - called once during the actual build phase.  This target should perform any necessary steps to prepare the actual presentation for distribution. 
* `serve` - called at "runtime" of the container.  This should actually serve up the on `PORT 9000`

