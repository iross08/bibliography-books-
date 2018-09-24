data = read.csv("a1.csv",header=TRUE,sep=",")

book <- NULL

book$title = data$items_volumeInfo_title
book$Publisher = data$items_volumeInfo_publisher
book$Author0 = data$items_volumeInfo_authors_0  
book$Author1 = data$items_volumeInfo_authors_1 
#book$Author2 = data$items_volumeInfo_authors_2 
#book$Author3 = data$items_volumeInfo_authors_3 
#book$PublishedDate = data$items_volumeInfo_publishedDate 
book$PageNumber = data$items_volumeInfo_pageCount
#book$Identifier = data$items_volumeInfo_industryIdentifiers_0_identifier
book$Category = data$items_volumeInfo_categories_0
#book$Description = data$items_volumeInfo_description

write.csv(book, file = "bookInfo.csv",append = TRUE)
