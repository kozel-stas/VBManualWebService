var renderArticle = function () {
    this.articleID = window.location.search.replace('?', '').split("&")[0].replace("id=", "");
    this.topicID = window.location.search.replace('?', '').split("&")[1].replace("topicID=", "");

    this.article = getArticle(this.articleID, this.topicID);

    var docAuthor = document.getElementById("authorContainer");
    var docContent = document.getElementById("articleContent");
    var docName = document.getElementById("articleName");

    var author = this.article.getAuthor();

    docAuthor.innerText = "Author: " + author.getFirstName() + " " + author.getLastName() + ", speciality: " + author.getSpeciality();

    docName.innerText = this.article.getName();

    docContent.innerHTML = this.article.getContent();

};

renderArticle();

var updateButtonClicked = function () {
    window.location.href = "articleRedactor.html?topicID=" + this.topicID + "&articleID=" + this.articleID;
};

var deleteButtonClicked = function () {
    deleteArticle(this.topicID, this.articleID);
    window.location.href = "topic.html?id=" + this.topicID;
};