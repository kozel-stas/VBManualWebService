var renderAttributes = function () {
    this.topicID = window.location.search.replace('?', '').split("&")[0].replace("topicID=", "");
    var optionEL = document.getElementById("authorSelect");

    var authors = getAuthors(0, getAuthorTotalNumber());
    for (var i = 0; i < authors.size(); i++) {
        var author = authors.get(i);
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
        this.articleID = href[1].replace("articleID=", "");
        var docAuthor = document.getElementById("authorSelect");
        var docContent = document.getElementById("textArea");
        var docName = document.getElementById("articleName");

        console.log(this.articleID);
        console.log(this.topicID);
        var article = getArticle(this.articleID, this.topicID);
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
};

renderOldArticleIfPresent();

var saveArticleButton = function () {
    var optionEL = document.getElementById("authorSelect");
    var option = optionEL.options[optionEL.selectedIndex].id;
    var name = document.getElementById("articleName").innerText;
    var content = document.getElementById("textArea").value;
    if (option && name && content && this.topicID) {
        if (this.mode !== "UPDATE") {
            addArticle(this.topicID, name, content, option.replace("author_", ""));
            window.location.href = "topic.html?id=" + this.topicID;
        } else {
            updateArticle(this.topicID, this.articleID, name, content, option.replace("author_", ""));
            window.location.href = "article.html?id=" + this.articleID + "&topicID=" + this.topicID;
        }
    }
};