var renderTopic = function () {
    var ID = window.location.search.replace('?', '').replace("id=", "");
    var topic = getTopic(ID);
    var articles = getArticles(ID);

    var topicDoc = document.getElementById("topicName");
    while (topicDoc.firstChild) {
        topicDoc.firstChild.remove();
    }
    if (topic != null) {
        var author = topic.getAuthor();
        var h1 = document.createElement("h1");
        h1.innerText = "Topic name: " + topic.getName() + " Author:  " + author.getFirstName() + " " + author.getLastName();
        topicDoc.appendChild(h1);
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
        a.href = "article.html?id=" + article.getId();
        a.classList.add("disabled");
        var author = article.getAuthor();

        a.innerText = "Name: " + article.getName() + " Author: " + author.getFirstName() + " " + author.getLastName();

        div.appendChild(a);
        domElement.appendChild(div);
    }

};

renderTopic();