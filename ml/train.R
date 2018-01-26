#Check if required packages are installed, if not, install
#write("Check if required packages are installed, if not, install.", stderr()) 
write("File opened.", stderr())  
list.of.packages <- c("caret")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, contriburl='https://cloud.r-project.org/src/contrib', dependencies=TRUE)

suppressMessages(library(caret))


f <- file("stdin")
open(f)

  
MAXBATCH=10000
MINBATCH=10
i=0

tmp <- data.frame("DefaulCol"=character())
while(TRUE) {
        line <- readLines(f,n=1)
        if( i < MAXBATCH && length(strsplit(line,",")) > 0 && length(strsplit(line,",")[[1]]) == 6 ){
                i=i+1                
                df<-data.frame(line)
                names(df) <- c("DefaultCol")
                tmp <- rbind(tmp,df)
                write("Adding batches.", stderr()) 
                next
        }
        if( i > MINBATCH ) {
                dataset <- data.frame(do.call('rbind', strsplit(as.character(tmp$DefaultCol),',',fixed=TRUE)))
                names(dataset) <- c("speed", "battery", "rank", "user", "timest", "id")
                write("Collected one batch.", stderr()) 
                # Run algorithms using 10-fold cross validation
                control <- trainControl(method="cv", number=10)
                metric <- "Accuracy"

                # I think this improves the script
                write("Start training run of the batch.", stderr()) 
                # kNN
                set.seed(7)
                fit.knn <- train(user~., data=dataset, method="knn", metric=metric, trControl=control)
                saveRDS(fit.knn,"/tmp/model.rds")
                write("Model saved.", stderr())
                write("/tmp/model.rds", stdout())

                # reset accumulators
                i=0
                tmp <- data.frame("DefaulCol"=character())
        }
}
 
close(f)


