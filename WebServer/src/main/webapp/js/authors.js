document.getElementById("submit").onclick = function (ev) {
    var lastName = document.getElementById("lastName").value;
    var firstName = document.getElementById("firstName").value;
    var speciality = document.getElementById("speciality").value;

    if (lastName && firstName && speciality) {
        window.registerAuthor(firstName, lastName, speciality);
    }
};

var renderAuthors = function () {
    var domElement = document.getElementById("authorsContainer");

    var authors = window.getAuthors();
    for (var i = 0; i < authors.length; i++) {
        var author = authors[i];
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
    var maxPage = Math.ceil(window.getAuthorTotalNumber() / 10);

    if (window.page == 1 || maxPage == 0) {
        dom.innerHTML += "<li class=\"disabled\"><a href=\"authors?page=1\"> Предыдущая </a></li>";
    } else {
        dom.innerHTML += "<li><a href=\"authors?page=" + (window.page - 1) + "\"> Предыдущая </a></li>";
    }
    if (window.page == 1) {
        dom.innerHTML += "<li class=\"active\"><a href=\"authors?page=1\"> 1 </a></li>";
        if (maxPage > 1) {
            dom.innerHTML += "<li><a href=\"authors?page=2\"> 2 </a></li>";
            if (maxPage > 2) {
                dom.innerHTML += "<li><a href=\"authors?page=" + maxPage + "\"> " + maxPage + " </a></li>";
            }
        }
    } else {
        if (maxPage > 1) {
            dom.innerHTML += "<li><a href=\"authors?page=1\"> 1 </a></li>";
            dom.innerHTML += "<li class=\"active\"><a href=\"authors?page=" + window.page + "\"> " + window.page + " </a></li>";
            if (maxPage > 2) {
                dom.innerHTML += "<li><a href=\"authors?page=" + maxPage + "\"> " + maxPage + " </a></li>"
            }
        }
    }

    if (maxPage == window.page || maxPage == 0) {
        dom.innerHTML += "<li class=\"disabled\"><a href=\"authors?page=" + (window.page) + "\"/> Следующая </a></li>";
    } else {
        dom.innerHTML += "<li><a href=\"authors?page=" + (window.page - 1 + 2) + "\"/> Следующая </a></li>";
    }
};

renderPaginator();