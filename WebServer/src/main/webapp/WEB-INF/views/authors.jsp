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
        <%@include file="Topic.js"%>
        <%@include file="Article.js"%>
        window.page = parseInt("${page}");
        window.getAuthors = function () {
            var res = [];
            <c:forEach var="author" items="${authors}">
            res.push(new Author("${author.id}", "${author.firstName}", "${author.lastName}", "${author.speciality}"));
            </c:forEach>
            return res;
        };

        window.getAuthorTotalNumber = function () {
            return parseInt("${authorTotalNumber}");
        };

        window.registerAuthor = function (name, lastName, speciality) {
            var url = "${pageContext.request.contextPath}/authors";
            var body = {
                id: "",
                firstName: name,
                lastName: lastName,
                speciality: speciality
            };
            var http = new XMLHttpRequest();
            http.onreadystatechange = function (ev) {
                window.location.href = "${pageContext.request.contextPath}/authors";
            };
            http.open('POST', url, false);
            http.send(JSON.stringify(body));
        }
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
                            <li class="active"><a href="${pageContext.request.contextPath}/authors">Authors</a></li>
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
                <div class="col-lg-6 col-lg-offset-3 col-md-8 col-md-offset-2 text-center">
                    <div class="intro animate-box">
                        <h1>Authors</h1>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <main id="main">
        <div class="container">
            <div class="col-md-8 col-md-offset-2 animate-box">
                <form action="">
                    <div class="form-group row">
                        <div class="col-md-6 field">
                            <label for="firstname">First Name</label>
                            <input type="text" name="FName" id="firstName" class="form-control">
                        </div>
                        <div class="col-md-6 field">
                            <label for="lastname">Last Name</label>
                            <input type="text" name="FName" id="lastName" class="form-control">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-6 field">
                            <label for="speciality">Speciality</label>
                            <input type="text" name="FName" id="speciality" class="form-control">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-12 field">
                            <input type="submit" id="submit" class="btn btn-primary" value="Register as author">
                        </div>
                    </div>
                </form>
            </div>
            <!-- <div class="col-md-4"></div> -->
        </div>
    </main>


    <section id="services">
        <div id="authorsContainer" class="container">

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

<script src="${pageContext.request.contextPath}/js/authors.js"></script>

</body>
</html>

