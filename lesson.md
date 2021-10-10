# Workshop Lesson Plan

For the Dockerized Covid Dash in R repository.

## Setup

Fork the repository on GitHub.

Clone the fork locally.

```bash
git clone https://github.com/<username>/plotly_visualization_workshop
cd plotly_visualization_workshop
```

Set your git email and name for commits.

```bash
git config --global user.email "<email>"
git config --global user.name "<name>"
```

## Run local apps

Build the Plotly Docker image.

```bash
docker build -t workshop .
```

Use a container to test the default sample.R script.

```bash
docker run --rm -p 8050:8050 workshop
```

Use containers to test the additional R scripts.

```bash
docker run --rm -p 8050:8050 workshop sample_withloop.R
docker run --rm -p 8050:8050 workshop sample_loop_plus_selector.R
```

Change the default container script.

Open `Dockerfile` and change line 13 from:

    CMD ["sample.R"]

to:

    CMD ["sample_withloop.R"]

Rebuild the Plotly Docker image. Caching should make this faster.

```bash
docker build -t workshop .
```

Test the new container default.

```bash
docker run --rm -p 8050:8050 workshop
```

Commit and push the change to the GitHub fork.

```bash
git add .
git commit -m "New default script"
```

## Run a remote app

Log in to Heroku through the command line using your Heroku account credentials.

```bash
heroku login -i
```

Create a new app in Heroku.

```bash
heroku create --stack container viz-workshop-<unique>
```

Push the code to the Heroku app and deploy.

```bash
git push heroku main
```

Visit the running app in a browser window.

https://viz-workshop-<unique>.herokuapp.com/

## Cleanup

Remove the local Docker image.

```bash
docker image rm workshop
```

Remove the Heroku app.

```bash
heroku apps:destroy viz-workshop-<unique>
```
