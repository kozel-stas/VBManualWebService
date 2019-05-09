function Article(id, name, content, author) {

    this.getId = function () {
        return id;
    };

    this.getName = function () {
        return name;
    };

    this.getContent = function () {
        return content;
    };

    this.getAuthor = function () {
        return author;
    }

}