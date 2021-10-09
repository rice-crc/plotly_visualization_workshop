# Dockerized Covid Dash in R

## Table of Contents

* [Getting Started](#getting-started)
	* [Data and Apps](#data-and-apps)
	* [Requirements](#requirements)
	* [Fork and Clone the Project](#fork-and-clone-the-project)
* [Local Deployment](#local-deployment)
* [Remote Deployment](#remote-deployment)
* [Making Code Changes](#making-code-changes)
* [Cleanup](#cleanup)

## Getting Started

This repo contains 3 builds of a Plotly app in R for quantifying covid-related mortality.

It also contains a Dockerfile for deploying local and remote environments.

### Data and Apps

These apps parse a large csv (~50MB) from the CDC: https://data.cdc.gov/NCHS/Weekly-counts-of-death-by-jurisdiction-and-cause-o/u6jv-9ijr/

* sample.R displays weekly mortality by for one cause, state, and year
* sample_withloop.R -- by multiple years for one cause and state
* sample_loop_plus_selector.R -- by multiple years with state, cause, & count type selectors

### Requirements

* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [git](https://git-scm.com/downloads)
* [heroku-cli](https://devcenter.heroku.com/articles/heroku-cli#download-and-install)
* [A Heroku account](https://heroku.com/)

### Fork and Clone the Project

Fork the [rice-crc/plotly_visualization_workshop](https://github.com/baylorcollegeofmedicine/bcm-drupal) repository on GitHub.

Clone the fork locally. Substitute your GitHub username.

```bash
git clone https://github.com/<username>/plotly_visualization_workshop
cd plotly_visualization_workshop
```

[Return to Top](#table-of-contents)

## Local Deployment

Build the Plotly Docker image.

```bash
docker build -t workshop .
```

Use a container to test the default sample.R script.

```bash
docker run --rm -p 8050:8050 workshop
```

View running apps by opening a browser window and visiting http://0.0.0.0:8050/.
Stop and remove containers by hitting `ctrl-c` on the command line.

Use containers to test the additional R scripts.

```bash
docker run --rm -p 8050:8050 workshop sample_withloop.R
docker run --rm -p 8050:8050 workshop sample_loop_plus_selector.R
```

[Return to Top](#table-of-contents)

## Remote Deployment

Create a new app in Heroku. Substitute a unique string in the app name.

```bash
heroku create --stack container viz-workshop-<unique>
```

Push the code to the Heroku app and deploy.

```bash
git push heroku main
```

[Return to Top](#table-of-contents)

## Making Code Changes

After making code changes, test the app locally by following the "Local
Deployment" section above.

When ready, commit and push the changes to your GitHub fork.

```bash
git add .
git commit -m "<description of changes>"
git push
```

Deploy the new code to your Heroku app.

```bash
git push heroku main
```

[Return to Top](#table-of-contents)

## Cleanup

Remove the local Docker image.

```bash
docker image rm workshop
```

Remove the Heroku app.

```bash
heroku apps:destroy viz-workshop-<unique>
```

[Return to Top](#table-of-contents)
