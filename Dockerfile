FROM plotly/heroku-docker-r:3.6.2_heroku18

WORKDIR /app

COPY src/init.R .
RUN /usr/bin/R --no-init-file --no-save --quiet --slave -f init.R

COPY src/ .

EXPOSE 8050

ENTRYPOINT ["/usr/bin/R", "--no-save", "-f"]
CMD ["sample.R"]
