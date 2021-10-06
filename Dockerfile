FROM plotly/heroku-docker-r:3.6.2_heroku18 as base

# install dependencies with init.R
COPY init.R /app/init.R
RUN /usr/bin/R --no-init-file --no-save --quiet --slave -f /app/init.R

from base as build

COPY . /app/

EXPOSE 8050

CMD cd /app && /usr/bin/R --no-save -f /app/sample.R
