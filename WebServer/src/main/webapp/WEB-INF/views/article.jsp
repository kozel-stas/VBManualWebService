<%@ page import="core.model.Author" %>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>
<%@ page import="core.model.Article" %>
<%@ page pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<!--[if lt IE 7]>
<html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>
<html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>
<html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Visual Basic manual</title>

    <!-- Facebook and Twitter integration -->
    <meta property="og:title" content=""/>
    <meta property="og:image" content=""/>
    <meta property="og:url" content=""/>
    <meta property="og:site_name" content=""/>
    <meta property="og:description" content=""/>
    <meta name="twitter:title" content=""/>
    <meta name="twitter:image" content=""/>
    <meta name="twitter:url" content=""/>
    <meta name="twitter:card" content=""/>


    <script>
        <%@include file="Author.js"%>
        <%@include file="Article.js"%>
        <%@include file="Topic.js"%>
        window.getArticle = function () {
            <%Author author = (Author) request.getAttribute("author");;
              Article article = (Article) request.getAttribute("article");%>
            var content = "<%= StringEscapeUtils.escapeEcmaScript(article.getContent())%>";
            var name = "<%= StringEscapeUtils.escapeEcmaScript(article.getName())%>";
            var id = "<%= StringEscapeUtils.escapeEcmaScript(article.getId())%>";

            var idAuthor = "<%= StringEscapeUtils.escapeEcmaScript(author.getId())%>";
            var firstNameAuthor = "<%= StringEscapeUtils.escapeEcmaScript(author.getFirstName())%>";
            var secondNameAuthor = "<%= StringEscapeUtils.escapeEcmaScript(author.getLastName())%>";
            var speciality = "<%= StringEscapeUtils.escapeEcmaScript(author.getSpeciality())%>";
            return new Article(id, name, content, new Author(idAuthor, firstNameAuthor, secondNameAuthor, speciality));
        };
        window.getTopic = function () {
            return new Topic("${topic.id}", "${topic.name}", new Author("${authorT.id}", "${authorT.firstName}", "${authorT.lastName}", "${authorT.speciality}"))
        };

        window.deleteArticle = function () {
            var url = "${pageContext.request.contextPath}/article";
            var http = new XMLHttpRequest();
            http.onreadystatechange = function (ev) {
                window.location.href = "${pageContext.request.contextPath}/topic?id=" + getTopic().getId();
            };
            http.open('DELETE', url + "?topicID=" + getTopic().getId() + "&articleID=" + getArticle().getId(), false);
            http.send();
        };

    </script>
    <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico">

    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,300,700|Roboto:300,400' rel='stylesheet'
          type='text/css'>

    <!-- Animate.css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css">
    <!-- Icomoon Icon Fonts-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/icomoon.css">
    <!-- Bootstrap  -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">


    <!-- Modernizr JS -->
    <script src="${pageContext.request.contextPath}/js/modernizr-2.6.2.min.js"></script>
    <!-- FOR IE9 below -->
    <!--[if lt IE 9]>
    <script src="${pageContext.request.contextPath}/js/respond.min.js"></script>
    <![endif]-->

</head>
<body>
<div class="box-wrap">
    <header role="banner" id="fh5co-header">
        <div class="container">
            <nav class="navbar navbar-default">
                <div class="row">
                    <div class="col-md-3">
                        <div class="fh5co-navbar-brand">
                            <a class="fh5co-logo" href="${pageContext.request.contextPath}/topics"><img
                                    src="${pageContext.request.contextPath}/images/brand-nav.png"
                                    alt="Closest Logo"></a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <ul class="nav text-center">
                            <li><a href="${pageContext.request.contextPath}/topics"><span>Topics</span></a></li>
                            <li><a href="${pageContext.request.contextPath}/authors">Authors</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
    </header>
    <!-- END: header -->
    <section id="intro">
        <div class="container">
            <div class="row">
                <button id="updateButton" onclick="updateButtonClicked()" type="button" class="btn col-md-6">Update
                    article
                </button>
                <button id="deleteButton" onclick="deleteButtonClicked()" type="button" class="btn col-md-6">Delete
                    article
                </button>
            </div>
            <div class="row">
                <div class="col-lg-6 col-lg-offset-3 col-md-8 col-md-offset-2 text-center">
                    <div id="articleName" class="intro animate-box">

                    </div>
                </div>
            </div>
        </div>
    </section>

    <main id="main">
        <div class="container">
            <div id="articleContent" class="col-md-8 col-md-offset-2 animate-box">

            </div>
            <!-- <div class="col-md-4"></div> -->
        </div>
    </main>

    <section id="services">
        <div id="authorContainer" class="container">

        </div>
    </section>

    <jsp:include page="footer.jsp"/>
</div>
<!-- END: box-wrap -->

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<!-- jQuery Easing -->
<script src="${pageContext.request.contextPath}/js/jquery.easing.1.3.js"></script>
<!-- Bootstrap -->
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<!-- Waypoints -->
<script src="${pageContext.request.contextPath}/js/jquery.waypoints.min.js"></script>

<!-- Main JS (Do not remove) -->
<script src="${pageContext.request.contextPath}/js/main.js"></script>

<script src="${pageContext.request.contextPath}/js/article.js"></script>

</body>
</html>

