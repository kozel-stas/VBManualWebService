var renderTopic = function () {
    var ID = window.location.search.replace('?', '').split("&")[0].replace("id=", "");
    this.page = window.location.search.replace('?', '').split("&")[1].replace("page=", "");
    if (isNaN(parseInt(this.page))) {
        this.page = 1;
    } else {
        this.page = parseInt(this.page)
    }

    this.topic = getTopic(ID);
    var articles = getArticles(ID, (this.page - 1) * 10, 10);

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

var renderPaginator = function () {
    var dom = document.getElementById("paginator");
    var maxPage = Math.ceil(getArticleTotalNumber(this.topic.getId()) / 10);

    if (this.page == 1 || maxPage == 0) {
        dom.innerHTML += "<li class=\"disabled\"><a href=\"topic.html?id=" + this.topic.getId() + "&page=1\"> Предыдущая </a></li>";
    } else {
        dom.innerHTML += "<li><a href=\"topic.html?id=" + this.topic.getId() + "&page=" + (this.page - 1) + "\"> Предыдущая </a></li>";
    }
    if (this.page == 1) {
        dom.innerHTML += "<li class=\"active\"><a href=\"topic.html?id=" + this.topic.getId() + "&page=1\"> 1 </a></li>";
        if (maxPage > 1) {
            dom.innerHTML += "<li><a href=\"topic.html?id=" + this.topic.getId() + "&page=2\"> 2 </a></li>";
            if (maxPage > 2) {
                dom.innerHTML += "<li><a href=\"topic.html?id=" + this.topic.getId() + "%page=" + maxPage + "\"> " + maxPage + " </a></li>";
            }
        }
    } else {
        if (maxPage > 1) {
            dom.innerHTML += "<li><a href=\"topic.html?id=" + this.topic.getId() + "&page=1\"> 1 </a></li>";
            dom.innerHTML += "<li class=\"active\"><a href=\"topic.html?id=" + this.topic.getId() + "&page=" + this.page + "\"> " + this.page + " </a></li>"
            if (maxPage > 2) {
                dom.innerHTML += "<li><a href=\"topic.html?id=" + this.topic.getId() + "&page=" + maxPage + "\"> " + maxPage + " </a></li>"
            }
        }
    }

    if (maxPage == this.page || maxPage == 0) {
        dom.innerHTML += "<li class=\"disabled\"><a href=\"topic.html?id=" + this.topic.getId() + "&page=" + (this.page) + "\"/> Следующая </a></li>";
    } else {
        dom.innerHTML += "<li><a href=\"topic.html?id=" + this.topic.getId() + "&page=" + (this.page - 1 + 2) + "\"/> Следующая </a></li>";
    }
};

renderPaginator();