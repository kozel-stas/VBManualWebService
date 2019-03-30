var redrawTopics = function () {
    var topicList = getTopics();
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
        a.href = "topic.html?id=" + topicObject.getId();
        a.classList.add("disabled");
        var author = topicObject.getAuthor();

        a.innerText = "Name: " + topicObject.getName() + " Author: " + author.getFirstName() + " " + author.getLastName();

        div.appendChild(a);
        domElement.appendChild(div);
    }
};

redrawTopics();
