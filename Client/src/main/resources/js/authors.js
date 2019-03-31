document.getElementById("submit").onclick = function (ev) {
    var lastName = document.getElementById("lastName").value;
    var firstName = document.getElementById("firstName").value;
    var speciality = document.getElementById("speciality").value;

    if (lastName && firstName && speciality) {
        registerAuthor(firstName, lastName, speciality);
    }
};

var renderAuthors = function () {
    var domElement = document.getElementById("authorsContainer");

    var authors = getAuthors();
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