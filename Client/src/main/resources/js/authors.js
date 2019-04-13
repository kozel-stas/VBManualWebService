document.getElementById("submit").onclick = function (ev) {
    var lastName = document.getElementById("lastName").value;
    var firstName = document.getElementById("firstName").value;
    var speciality = document.getElementById("speciality").value;

    if (lastName && firstName && speciality) {
        registerAuthor(firstName, lastName, speciality);
    }
};

var renderAuthors = function () {
    this.page = window.location.search.replace('?', '').replace("page=", "");
    if (isNaN(parseInt(this.page))) {
        this.page = 1;
    }

    var domElement = document.getElementById("authorsContainer");

    var authors = getAuthors((this.page - 1) * 10, 10);
    for (var i = 0; i < authors.size(); i++) {
        var author = authors.get(i);
        var div = document.createElement("div");
        div.classList.add("col-md-12");
        div.classList.add("text-center");

        div.innerText = "Author: " + author.getFirstName() + " " + author.getLastName() + ", Speciality: " + author.getSpeciality();

        domElement.appendChild(div);
    }
};

renderAuthors();

var renderPaginator = function () {
    var dom = document.getElementById("paginator");
    var maxPage = Math.ceil(getAuthorTotalNumber() / 10);

    if (this.page == 1 || maxPage == 0) {
        dom.innerHTML += "<li class=\"disabled\"><a href=\"authors.html?page=1\"> Предыдущая </a></li>";
    } else {
        dom.innerHTML += "<li><a href=\"authors.html?page=" + (this.page - 1) + "\"> Предыдущая </a></li>";
    }
    if (this.page == 1) {
        dom.innerHTML += "<li class=\"active\"><a href=\"authors.html?page=1\"> 1 </a></li>";
        if (maxPage > 1) {
            dom.innerHTML += "<li><a href=\"authors.html?page=2\"> 2 </a></li>";
            if (maxPage > 2) {
                dom.innerHTML += "<li><a href=\"authors.html?page=" + maxPage + "\"> " + maxPage + " </a></li>";
            }
        }
    } else {
        if (maxPage > 1) {
            dom.innerHTML += "<li><a href=\"authors.html?page=1\"> 1 </a></li>";
            dom.innerHTML += "<li class=\"active\"><a href=\"authors.html?page=" + this.page + "\"> " + this.page + " </a></li>"
            if (maxPage > 2) {
                dom.innerHTML += "<li><a href=\"authors.html?page=" + maxPage + "\"> " + maxPage + " </a></li>"
            }
        }
    }

    if (maxPage == this.page || maxPage == 0) {
        dom.innerHTML += "<li class=\"disabled\"><a href=\"authors.html?page=" + (this.page) + "\"/> Следующая </a></li>";
    } else {
        dom.innerHTML += "<li><a href=\"authors.html?page=" + (this.page - 1 + 2) + "\"/> Следующая </a></li>";
    }
};

renderPaginator();