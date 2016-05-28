#! /usr/bin/Rscript

resultFile			<- 'examples/RXFK.txt'
robotFile			<- 'robots.txt'
outputFile			<- 'results.txt'

results				<- read.table(resultFile,skip=1,fill=TRUE,sep='\t',header=TRUE)
results				<- results[,c('Pos','Group')]

robots				<- read.table(robotFile,sep='\t',header=TRUE)

results				<- merge(results,robots,by.x='Pos',by.y='LC.Well')

wells				<- c(outer(c('A','B','C','D','E','F','G','H'),1:12,FUN=paste0))

results$Well		<- factor(results$Well, levels = wells)
results$Plate		<- factor(results$Plate, levels = c(1,2,3,4))

results				<- results[order(results$Plate,results$Well),]
rownames(results)	<- NULL
results				<- results[,c('Plate','Well','Group')]

write.table(results,file=outputFile,row.names=FALSE,col.names=TRUE,quote=FALSE,sep='\t')
