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
#cause<-"Diabetes"
weighted<-"Unweighted"
#year<-2016
years<-unique(counts$Year)

#https://plotly.com/python/line-charts/


causes<-unique(counts$`Cause Subgroup`)
cause_dropdown_opts<-list()
for(i in causes){
	cause_dropdown_opts[[length(cause_dropdown_opts)+1]]<-list(label=i,value=i)
}


weighted_opts<-unique(counts$`Type`)
weighted_radio_opts<-list()
for(i in weighted_opts){
	weighted_radio_opts[[length(weighted_radio_opts)+1]]<-list(label=i,value=i)
}

jurisdictions<-unique(counts$`Jurisdiction`)
jurisdiction_dropdown_opts<-list()
for(i in jurisdictions){
	jurisdiction_dropdown_opts[[length(jurisdiction_dropdown_opts)+1]]<-list(label=i,value=i)
}

print(weighted_radio_opts)
print(jurisdiction_dropdown_opts)

app$layout(
htmlDiv(list(

	htmlDiv(list(
			dccGraph(id='fizz',figure=fig)
	)),
	
	htmlDiv(
			list(
				htmlLabel('Listed Cause of Death'),
				dccDropdown(
					id = 'cause_dropdown',
					options = cause_dropdown_opts,
					value = 'Diabetes'
				),
				
			
				htmlLabel('State'),
				dccDropdown(
					id = 'jurisdiction_dropdown',
					options = jurisdiction_dropdown_opts,
					value = "Texas"
				),
				
				htmlLabel('Weighted or Raw Counts'),
				dccRadioItems(
					id = 'weighted_radio',
					options = weighted_radio_opts,
					value = "Unweighted"
				)
			)
	)
	
	
	

))
)







app$callback(
	output = list(id='fizz',property='figure'),
	params = list(
		input(id='cause_dropdown',property='value'),
		input(id='jurisdiction_dropdown',property='value'),
		input(id='weighted_radio',property='value')
	),
	function(cause,jurisdiction,weighted) {
		
		for(year in years){
		print(year)
		counts_filtered<-filter(counts,`Type`==weighted,`Jurisdiction`==jurisdiction,`Cause Subgroup`==cause,`Year`==year)
		df<-counts_filtered %>% select(`Number of Deaths`,`Week`)
		fig <- fig %>% add_trace(
			x=df$Week,
			y=df$`Number of Deaths`,
			name=year,
			type='scatter',
			mode='lines'
		)
		}

		fig <- fig %>% layout(
			title=paste(c(jurisdiction,cause,"Mortality"),collapse=" "),
			xaxis=list('title'='Week'),
			yaxis=list('title'="title"),
			paper_bgcolor = '#c3d1e8'

		)

		result<-fig
	}
)







app$run_server(host='0.0.0.0',port=Sys.getenv('PORT',8050))





