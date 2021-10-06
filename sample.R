library(plotly)
library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(readr)
library(tidyr)
library(dplyr)

app<-Dash$new()
fig<-plot_ly()

#https://dashr.plotly.com/

counts <- read_delim("Weekly_counts_of_death_by_jurisdiction_and_cause_of_death.csv",delim=";")

jurisdiction<-"Texas"
cause<-"Diabetes"
weighted<-"Unweighted"
year<-2016

#https://plotly.com/python/line-charts/

counts_filtered<-filter(counts,`Type`==weighted,`Jurisdiction`==jurisdiction,`Cause Subgroup`==cause,`Year`==year)
df<-counts_filtered %>% select(`Number of Deaths`,`Week`)

fig <- plot_ly()

fig <- fig %>% add_trace(
	x=df$Week,
	y=df$`Number of Deaths`,
	name=year,
	type='scatter',
	mode='lines'
)


fig <- fig %>% layout(
	title=paste(c(jurisdiction,cause,"Mortality"),collapse=" "),
	xaxis=list('title'='Week'),
	yaxis=list('title'="title"),
	paper_bgcolor = '#c3d1e8'

)


app$layout(
	htmlDiv(list(
			dccGraph(id='fizz',figure=fig)
		))
)

app$run_server(host='0.0.0.0',port=Sys.getenv('PORT',8050))





