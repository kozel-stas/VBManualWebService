var redrawTopics = function () {
    this.page = window.location.search.replace('?', '').replace("page=", "");
    if (isNaN(parseInt(this.page))) {
        this.page = 1;
    } else {
        this.page = parseInt(this.page)
    }

    var topicList = getTopics((this.page - 1) * 10, 10);
    var domElement = document.getElementById("topicContainer");
    while (domElement.firstChild) {
        domElement.firstChild.remove();
    }
    for (var i = 0; i < topicList.size(); i++) {
        var topicObject = topicList.get(i);
        var div = document.createElement("div");
        div.classList.add("col-md-12");

        div.classList.add("text-center");
        var a = document.createElement("a");
        a.href = "topic.html?id=" + topicObject.getId() + "&page=1";
        a.classList.add("disabled");
        var author = topicObject.getAuthor();

        a.innerText = "Name: " + topicObject.getName() + " Author: " + author.getFirstName() + " " + author.getLastName();

        div.appendChild(a);
        domElement.appendChild(div);
    }
};

redrawTopics();

var createButtonClicked = function () {
    var bEl = document.getElementById("createButton");
    var fEl = document.getElementById("createTopic");


    bEl.classList.add("invisible");
    fEl.classList.remove("invisible");
    fEl.innerHTML = "<div class=\"form-group row\">\n" +
        "                    <div class=\"col-md-6 field\">\n" +
        "                        <label for=\"topicName\">Topic Name</label>\n" +
        "                        <input type=\"text\" name=\"FName\" id=\"topicName\" class=\"form-control\">\n" +
        "                    </div>\n" +
        "                    <div class=\"col-md-6 field\">" +
        "                       <label for=\"authorSelect\">Author</label>" +
        "                        <select id=\"authorSelect\" class=\"form-control\">\n" +
        "                        </select>" +
        "                    </div>\n" +
        "                </div>" +
        "                <div class=\"form-group row\">\n" +
        "                    <div class=\"col-md-12 field\">\n" +
        "                        <input type=\"submit\" id=\"submit\" class=\"btn btn-primary\" value=\"Create topic\">\n" +
        "                    </div>\n" +
        "                </div>";

    var optionEL = document.getElementById("authorSelect");

    var authors = getAuthors();
    for (var i = 0; i < authors.size(); i++) {
        var author = authors.get(i);
        var op = document.createElement("option");

        op.innerText = "Author: " + author.getFirstName() + " " + author.getLastName() + ", Speciality: " + author.getSpeciality();
        op.id = "author_" + author.getId();

        optionEL.appendChild(op);
    }


    document.getElementById("submit").onclick = function (ev) {
        var name = document.getElementById("topicName").value;
        var option = optionEL.options[optionEL.selectedIndex].id;
        if (option && name) {
            addTopic(name, option.replace("author_", ""));
        }
    };

};

var renderPaginator = function () {
    var dom = document.getElementById("paginator");

    var maxPage = Math.ceil(getTopicTotalNumber() / 10);

    if (this.page == 1 || maxPage == 0) {
        dom.innerHTML += "<li class=\"disabled\"><a href=\"index.html?page=1\"> Предыдущая </a></li>";
    } else {
        dom.innerHTML += "<li><a href=\"index.html?page=" + (this.page - 1) + "\"> Предыдущая </a></li>";
    }
    if (this.page == 1) {
        dom.innerHTML += "<li class=\"active\"><a href=\"index.html?page=1\"> 1 </a></li>";
        if (maxPage > 1) {
            dom.innerHTML += "<li><a href=\"index.html?page=2\"> 2 </a></li>";
            if (maxPage > 2) {
                dom.innerHTML += "<li><a href=\"index.html?page=" + maxPage + "\"> " + maxPage + " </a></li>";
            }
        }
    } else {
        if (maxPage > 1) {
            dom.innerHTML += "<li><a href=\"index.html?page=1\"> 1 </a></li>";
            dom.innerHTML += "<li class=\"active\"><a href=\"index.html?page=" + this.page + "\"> " + this.page + " </a></li>"
            if (maxPage > 2) {
                dom.innerHTML += "<li><a href=\"index.html?page=" + maxPage + "\"> " + maxPage + " </a></li>"
            }
        }
    }

    if (maxPage == this.page || maxPage == 0) {
        dom.innerHTML += "<li class=\"disabled\"><a href=\"index.html?page=" + (this.page) + "\"/> Следующая </a></li>";
    } else {
        dom.innerHTML += "<li><a href=\"index.html?page=" + (this.page - 1 + 2) + "\"/> Следующая </a></li>";
    }
};

renderPaginator();


