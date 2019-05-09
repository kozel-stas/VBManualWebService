function Topic(id, name, author) {

    this.getId = function () {
        return id;
    };

    this.getName = function () {
        return name;
    };

    this.getAuthor = function () {
        return author;
    };

}