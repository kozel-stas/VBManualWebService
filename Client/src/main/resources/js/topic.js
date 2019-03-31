var renderTopic = function () {
    var ID = window.location.search.replace('?', '').replace("id=", "");
    this.topic = getTopic(ID);
    var articles = getArticles(ID);

    var topicDoc = document.getElementById("topicName");
    while (topicDoc.firstChild) {
        topicDoc.firstChild.remove();
    }
    if (topic != null) {
        this.author = this.topic.getAuthor();
        topicDoc.innerText = "Topic name: \"" + this.topic.getName() + "\", Author:  \"" + this.author.getFirstName() + " " + this.author.getLastName() + "\"";
    } else {
        throw "Topic is absent";
    }

    var domElement = document.getElementById("articlesContainer");

    for (var i = 0; i < articles.size(); i++) {
        var article = articles.get(i);
        var div = document.createElement("div");
        div.classList.add("col-md-12");

        div.classList.add("text-center");
        var a = document.createElement("a");
        a.href = "article.html?id=" + article.getId() + "&topicID=" + this.topic.getId();
        a.classList.add("disabled");
        var author = article.getAuthor();

        a.innerText = "Name: " + article.getName() + " Author: " + author.getFirstName() + " " + author.getLastName();

        div.appendChild(a);
        domElement.appendChild(div);
    }

};

renderTopic();

var deleteTopicButton = function () {
    deleteTopic(this.topic.getId());
    window.location.href = "index.html"
};

redirectToCreator = function () {
    window.location.href = "articleRedactor.html?topicID=" + this.topic.getId();
};