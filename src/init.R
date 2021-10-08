# R script to run author supplied code, typically used to install additional R packages
# contains placeholders which are inserted by the compile script
              # NOTE: this script is executed in the chroot context; check paths!

              r <- getOption('repos')
              r['CRAN'] <- 'http://cloud.r-project.org'
              options(repos=r)

              # ======================================================================

              # packages go here
              install.packages('lifecycle')
              install.packages('remotes')
              install.packages('plyr')
              install.packages('dash')
              install.packages('tidyr')
              install.packages('readr')
              install.packages('plotly')
		remotes::install_github('plotly/dashR', upgrade=TRUE)
