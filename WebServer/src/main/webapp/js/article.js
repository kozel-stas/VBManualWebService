var renderArticle = function () {
    this.article = window.getArticle();

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
    window.location.href = "articleRedactor?topicID=" + window.getTopic().getId() + "&articleID=" + window.getArticle().getId();
};

var deleteButtonClicked = function () {
    deleteArticle();
};