# Check if required packages are installed, if not, install
list.of.packages <- c("caret")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, contriburl='https://cloud.r-project.org/src/contrib', dependencies=TRUE)

suppressMessages(library(caret))


f <- file("stdin")
open(f)
write("file opened", stderr())  
count=30
i=0
 
doTrace <- function(...) cat(sprintf(...), sep='', file=stderr())

tmp <- data.frame("DefaulCol"=character())
while(i <= count) {
 
        if(i<count){
               write("putting lines together", stderr()) 
            
                if(length(line <- readLines(f,n=1)) > 0){

                    splitted=strsplit(line,",")
                    itemCount=length(splitted[[1]])

                    if(itemCount==6){
                        i=i+1
                        df<-data.frame(line)
                        names(df) <- c("DefaultCol")
                        tmp <- rbind(tmp,df)
                    }
                }
        }
        else {
                doTrace("starting inference")
                write("starting inference", stderr())
                dataset <- data.frame(do.call('rbind', strsplit(as.character(tmp$DefaultCol),',',fixed=TRUE)))
                names(dataset) <- c("speed", "battery", "rank", "testcase", "timest", "id")

                #read from RDS
                myknn <- readRDS("/tmp/model.rds")
                mypreds <- predict(myknn, dataset)
                write("Create inference result with length preds:", stderr())
                doTrace("Create inference result with length preds: %d, length dataset: %d, i %d \n", length(mypreds), length(dataset$testcase), i)
                myres <- confusionMatrix(mypreds, dataset$testcase)

                header <- c(".",".",".","...INFERENCE BATCH UPDATE...") 
                cat(header, sep="\n\n")
                print(myres)

                # reset accumulators
                i=0
                tmp <- data.frame("DefaulCol"=character())
        }
}
close(f)