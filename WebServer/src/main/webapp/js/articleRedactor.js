var renderAttributes = function () {
    var optionEL = document.getElementById("authorSelect");

    var authors = window.getAuthors();
    for (var i = 0; i < authors.length; i++) {
        var author = authors[i];
        var op = document.createElement("option");

        op.innerText = "Author: " + author.getFirstName() + " " + author.getLastName() + ", Speciality: " + author.getSpeciality();
        op.id = "author_" + author.getId();

        optionEL.appendChild(op);
    }
};

renderAttributes();

var renderOldArticleIfPresent = function () {
    var href = window.location.search.replace('?', '').split("&");
    if (href.length === 2) {
        this.mode = "UPDATE";
        var docAuthor = document.getElementById("authorSelect");
        var docContent = document.getElementById("textArea");
        var docName = document.getElementById("articleName");

        var article = window.getArticle();
        if (article != null) {
            var authorID = article.getAuthor().getId();

            for (var i; i < docAuthor.options.length; i++) {
                var option = docAuthor.options[i];
                if (option.id === "author_" + authorID) {
                    docAuthor.selectedIndex = i;
                    break;
                }
            }
            docName.innerText = article.getName();
            docContent.value = article.getContent();
        }
    }
};

renderOldArticleIfPresent();

var saveArticleButton = function () {
    var optionEL = document.getElementById("authorSelect");
    var option = optionEL.options[optionEL.selectedIndex].id;
    var name = document.getElementById("articleName").innerText;
    var content = document.getElementById("textArea").value;
    var topicID = window.getTopicID();
    if (option && name && content && topicID) {
        if (this.mode !== "UPDATE") {
            addArticle(topicID, name, content, option.replace("author_", ""));
            // window.location.href = "topic.html?id=" + this.topicID;
        } else {
            updateArticle(topicID, getArticle().getId(), name, content, option.replace("author_", ""));
            // window.location.href = "article.html?id=" + this.articleID + "&topicID=" + this.topicID;
        }
    }
};