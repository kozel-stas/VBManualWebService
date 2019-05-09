var renderTopic = function () {

    this.topic = window.getTopic();
    var articles = window.getArticles();

    var topicDoc = document.getElementById("topicName");
    while (topicDoc.firstChild) {
        topicDoc.firstChild.remove();
    }
    if (this.topic != null) {
        this.author = this.topic.getAuthor();
        topicDoc.innerText = "Topic name: \"" + this.topic.getName() + "\", Author:  \"" + this.author.getFirstName() + " " + this.author.getLastName() + "\"";
    } else {
        throw "Topic is absent";
    }

    var domElement = document.getElementById("articlesContainer");

    for (var i = 0; i < articles.length; i++) {
        var article = articles[i];
        var div = document.createElement("div");
        div.classList.add("col-md-12");

        div.classList.add("text-center");
        var a = document.createElement("a");
        a.href = "article?id=" + article.getId() + "&topicID=" + this.topic.getId();
        a.classList.add("disabled");
        var author = article.getAuthor();

        a.innerText = "Name: " + article.getName() + " Author: " + author.getFirstName() + " " + author.getLastName();

        div.appendChild(a);
        domElement.appendChild(div);
    }

};

renderTopic();

var deleteTopicButton = function () {
    window.deleteTopic();
};

redirectToCreator = function () {
    window.location.href = "articleRedactor?topicID=" + window.getTopic().getId();
};

var renderPaginator = function () {
    var dom = document.getElementById("paginator");
    var maxPage = Math.ceil(window.getArticleTotalNumber() / 10);

    if (window.page == 1 || maxPage == 0) {
        dom.innerHTML += "<li class=\"disabled\"><a href=\"topic?id=" + this.topic.getId() + "&page=1\"> Предыдущая </a></li>";
    } else {
        dom.innerHTML += "<li><a href=\"topic?id=" + this.topic.getId() + "&page=" + (window.page - 1) + "\"> Предыдущая </a></li>";
    }
    if (window.page == 1) {
        dom.innerHTML += "<li class=\"active\"><a href=\"topic?id=" + this.topic.getId() + "&page=1\"> 1 </a></li>";
        if (maxPage > 1) {
            dom.innerHTML += "<li><a href=\"topic?id=" + this.topic.getId() + "&page=2\"> 2 </a></li>";
            if (maxPage > 2) {
                dom.innerHTML += "<li><a href=\"topic?id=" + this.topic.getId() + "%page=" + maxPage + "\"> " + maxPage + " </a></li>";
            }
        }
    } else {
        if (maxPage > 1) {
            dom.innerHTML += "<li><a href=\"topic?id=" + this.topic.getId() + "&page=1\"> 1 </a></li>";
            dom.innerHTML += "<li class=\"active\"><a href=\"topic?id=" + this.topic.getId() + "&page=" + window.page + "\"> " + window.page + " </a></li>";
            if (maxPage > 2) {
                dom.innerHTML += "<li><a href=\"topic?id=" + this.topic.getId() + "&page=" + maxPage + "\"> " + maxPage + " </a></li>"
            }
        }
    }

    if (maxPage == window.page || maxPage == 0) {
        dom.innerHTML += "<li class=\"disabled\"><a href=\"topic?id=" + this.topic.getId() + "&page=" + (window.page) + "\"/> Следующая </a></li>";
    } else {
        dom.innerHTML += "<li><a href=\"topic?id=" + this.topic.getId() + "&page=" + (window.page - 1 + 2) + "\"/> Следующая </a></li>";
    }
};

renderPaginator();