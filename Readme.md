# Dockerized Covid Dash in R

This repo contains 3 builds of a Plotly app in R for quantifying covid-related mortality.

It also contains a Dockerfile for building the environment for local and remote deployment.

## Data and Apps

These apps parse a large csv (~50MB) from the CDC: https://data.cdc.gov/NCHS/Weekly-counts-of-death-by-jurisdiction-and-cause-o/u6jv-9ijr/

* 3 sample apps
	* sample.R displays weekly mortality by for one cause, state, and year
	* sample_withloop.R -- by multiple years for one cause and state
	* sample_loop_plus_selector.R -- by multiple years with state, cause, & count type selectors
* 1 production-ready app: excess_mortality.R, which draws on excess_stacked.R to do the calculation and graph formatting

## Local Deployment

This is based on the remote Heroku deployment for consistency and predictability

USE 2 TERMINAL WINDOWS:

### *BUILD* with:
`docker build .`

### *RUN* by getting your image id, then specifying the host and port to bind the service to.
1. `docker images` --> then copy IMAGEID
1. `docker run -p 0.0.0.0:8050:8050` IMAGEID
1. access in your browser at 0.0.0.0:8050
1. Now run docker ps
1. You will see a container with a random name running your image

### to *STOP*:
1. open a second terminal window
1. type `docker ps` and see your running container ID's
1. stop with `docker stop CONTAINER_ID`

### *REBUILD* with:
1. Changing some of your code
1. Running the build command again: `docker build .`
1. Rebuilds are fast, but the duplicate containers quickly take up a lot of space:

### *CLEAN UP* every once in a while with:
1. `docker images` to see your stopped image ID's
1. `docker image rm -f IMAGE_ID`

Note: deleting *all* of your images for this app will make your next rebuild slow.

## Remote Deployment

Once your local build is working well, you can easily deploy this to Heroku. Much of this is essentially copied from https://dashr.plotly.com/deployment

It depends on you having Heroku CLI installed and an account set up: https://devcenter.heroku.com/articles/git

*NOTE. MOVE THIS DIRECTORY OUT OF THE PARENT WORKSHOP DIRECTORY FIRST, OR IT WILL GOOF UP THE BELOW GIT COMMANDS*

	heroku create --stack container my-dash-app # change my-dash-app to a unique name
	git add . # add all files to git
	git commit -m 'Initial app boilerplate'		
	git push heroku master # deploy code to Heroku
	heroku ps:scale web=1  # runs the app after it's built

You should be able to access your app at https://my-dash-app.herokuapp.com (changing my-dash-app to the name of your app).

To update and redeploy:

	git status # view the changes
	git add .  # add all the changes
	git commit -m 'a description of the changes'
	git push heroku master


![dash1](https://raw.githubusercontent.com/JohnMulligan/covid_dashR/master/Screen%20Shot%202021-01-10%20at%209.36.38%20PM.png)

