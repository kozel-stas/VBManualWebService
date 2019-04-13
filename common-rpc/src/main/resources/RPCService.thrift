namespace java rpc.service.gen

struct Article {
    1: string articleId
    2: string articleName
    3: string content
    4: Author author
}

struct Topic {
   1: string topicId
   2: string topicName
   3: Author author;
}

struct Author{
    1: string authorId;
    2: string firstName
    3: string lastName
    4: string speciality
}

service VBManualService {

        list<Topic> getTopics(i32 offset, i32 number),

        i32 getAuthorTotalNumber(),

        i32 getTopicTotalNumber(),

        i32 getArticleTotalNumber(string topicId),

        Topic getTopic(string topicId),

        Article getArticle(string topicId, string articleId),

        Author getAuthor(string authorId),

        list<Article> getArticles(1: string topicId, i32 offset, i32 number),

        void deleteArticle(1: string topicId, 2: string articleId),

        void updateArticle(1: string topicId, 2: Article article),

        void addArticle(1: string topicId, 2: Article article),

        void addTopic(1: Topic topic),

        void deleteTopic(1: string topicId, Author author),

        void addAuthor(1: Author author),

        list<Author> getAuthors(i32 offset, i32 number)

}