\name{beer}
\docType{data}
\alias{beer}
\title{Data from the 2011 Atlanta Beer Survey}
\description{
  The data come from the 2011 Atlanta beer survey. Thanks to Kris Erickson for supplying the data.
	\itemize{
	  \item{respondent: Respondent ID}
	  \item{weeklyBeer: In an average week, how many beers do you consume? 
	  \itemize{
	  	\item 1 = Less than one per week
        \item 2 = 1-3 beers per week
        \item 3 = 4-6 beers per week
        \item 4 = 7-9 beers per week
        \item 5 = 10 or more beers per week
        }
       }
      \item{beerOut: What percentage of your beer consumption takes place outside of home in a restaurant, pub, or bar? 
	  \itemize{
	  	\item 1 =  0-25\%
        \item 2 = 26-50\%
        \item 3 = 51-75\%
        \item 4 = 76-100\%
        }
       } 
      \item{eatOut: In an average week, how often do you eat lunch or dinner at a sit-down restaurant or bar? 
	  \itemize{
	  	\item 1 = Less than once a week
        \item 2 = 1-3 times per week
        \item 3 = 4-6 times per week
        \item 4 = 7-9 times per week
        \item 5 = 10 or more times per week
        }
       }
      \item{selectRestaurant: How important is a restaurant's beer selection to you when choosing a restaurant? 
	  \itemize{
	  	\item 1 = Extremely Important	
        \item 2 = Moderately Important
        \item 3 = Not Too Important
        \item 4 = Not At All Important
        }
       }
      \item{selectPub: How important is a pub/tavern/sports bar's beer selection to you when choosing a pub/tavern/sports bar? 
	  \itemize{
	  	\item 1 = Extremely Important	
        \item 2 = Moderately Important
        \item 3 = Not Too Important
        \item 4 = Not At All Important
        }
       } 
      \item{orderLocal: How likely are you to order a beer because it was brewed in your local area? 
	  \itemize{
	  	\item 1 = Very Likely	
        \item 2 = Likely	
        \item 3 = Undecided	
        \item 4 = Unlikely	
        \item 5 = Very Unlikely
        }
       } 
      \item{onSiteBrew: How likely are you to visit a restaurant that brews beer on-site? 
	  \itemize{
	  	\item 1 = Very Likely	
        \item 2 = Likely	
        \item 3 = Undecided	
        \item 4 = Unlikely	
        \item 5 = Very Unlikely
        }
       }   
	  \item{massMarket: How likely are you to consume American-style Mass Market beers (e.g., Budweiser, Coors, Miller, PBR)?
	  \itemize{
	  	\item 1 = Very Likely	
        \item 2 = Likely	
        \item 3 = Undecided	
        \item 4 = Unlikely	
        \item 5 = Very Unlikely
        }
       }  
	  \item{lager: How likely are you to consume Lagers and Pilsners (e.g., Heineken, Amstel, Stella Artois, Corona, Warsteiner)?
	  \itemize{
	  	\item 1 = Very Likely	
        \item 2 = Likely	
        \item 3 = Undecided	
        \item 4 = Unlikely	
        \item 5 = Very Unlikely
        }
       }  

	  \item{wheat: How likely are you to consume Wheat beers (e.g., Hefeweizen, Hoegaarden, Paulaner)?
	  \itemize{
	  	\item 1 = Very Likely	
        \item 2 = Likely	
        \item 3 = Undecided	
        \item 4 = Unlikely	
        \item 5 = Very Unlikely
        }
       }  
	  \item{paleAle: How likely are you to consume Pale Ales and IPAs (e.g., Bass Ale, Sierra Nevada, Dogfish)?
	  \itemize{
	  	\item 1 = Very Likely	
        \item 2 = Likely	
        \item 3 = Undecided	
        \item 4 = Unlikely	
        \item 5 = Very Unlikely
        }
       }  
	  \item{brown: How likely are you to consume Brown Ales (e.g., Newcastle, Samuel Smith)?
	  \itemize{
	  	\item 1 = Very Likely	
        \item 2 = Likely	
        \item 3 = Undecided	
        \item 4 = Unlikely	
        \item 5 = Very Unlikely
        }
       }  
	  \item{stout: How likely are you to consume Stouts and Porters (e.g., Guinness, Taddy)?
	  \itemize{
	  	\item 1 = Very Likely	
        \item 2 = Likely	
        \item 3 = Undecided	
        \item 4 = Unlikely	
        \item 5 = Very Unlikely
        }
       }  
      \item{att1: How important is taste to you when selecting a beer? (1-10)}
      \item{att2: How important is pricee to you when selecting a beer? (1-10)}
      \item{att3: How important is origin (region, country) to you when selecting a beer? (1-10)}
      \item{att4: How important is healthiness (calories) to you when selecting a beer? (1-10)}
      \item{att5: How important is popularity to you when selecting a beer? (1-10)}
      \item{att6: How important is packaging/design to you when selecting a beer? (1-10)}
      \item{tasteNew: How likely are you to taste new beers or beer styles that you've never tried before?
	  \itemize{
	  	\item 1 = Very Likely	
        \item 2 = Likely	
        \item 3 = Undecided	
        \item 4 = Unlikely	
        \item 5 = Very Unlikely
        }
       } 
     \item{purchaseNew: How likely are you to purchase new beers or beer styles you've never tried before?	
	  \itemize{
	  	\item 1 = Very Likely	
        \item 2 = Likely	
        \item 3 = Undecided	
        \item 4 = Unlikely	
        \item 5 = Very Unlikely
        }
       } 
     \item{drinkCraft: Do you drink craft or microbrewed beer? (e.g., Samuel Adams, Sweetwater 420, Sierra Nevada)	
	  \itemize{
	  	\item 1 = Yes	
        \item 2 = No
        }
       }   
     \item{sierraNevada: On a scale from one to ten, how well do you enjoy Sierra Nevada?}
     \item{samAdams: On a scale from one to ten, how well do you enjoy Samuel Adams?}
     \item{sweetwater: On a scale from one to ten, how well do you enjoy Sweetwater?}
     \item{terrapin: On a scale from one to ten, how well do you enjoy Terrapin Beer?}
     \item{fatTire: On a scale from one to ten, how well do you enjoy New Belgium Fat Tire?}
     \item{magicHat: On a scale from one to ten, how well do you enjoy Magic Hat?}
     \item{dogfish: On a scale from one to ten, how well do you enjoy Dogfish?}
     \item{shinerBock: On a scale from one to ten, how well do you enjoy Shiner Bock?}
     \item{favorite: Do you have a favorite brand of beer?}
     \item{age: What is your age range?	
	  \itemize{
	  	\item 2 = 21-25
        \item 3 = 26-30
        \item 4 = 31-40
        \item 5 = 41-50
        \item 6 = 51-60
        \item 7 = 61+
        }
       } 
     \item{gender: What is your gender?	
	  \itemize{
	  	\item 1 = Male	
        \item 2 = Female
        }
       }   
    \item{years: How many years have you lived in the Atlanta or North Georgia area?}
    \item{income: What is your annual household income range?	
	  \itemize{
	  	\item 1 = Less than \$25,000
         \item 2 = \$25,001 to \$40,000
         \item 3 = \$40,001 to \$60,000
         \item 4 = \$60,001 to \$75,000
         \item 5 = \$75,001 to \$100,000
         \item 6 = Greater than \$100,000
        }
       }  

	}
}
\format{A data frame containing 350 rows (cases) and 37 columns (variables).}

\examples{
data(beer)
head(beer)
# Compute Coefficient Alpha for the six attribute items
coef_alpha(beer[16:21])
}

\keyword{data}
\keyword{datasets}

