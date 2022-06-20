<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="p" scope="request" type="viewmodel.HomepageViewModel"/>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>

<!doctype html>
<html>
<head>
    <title>My Bookstore</title>
    <meta charset="utf-8">
    <meta name="description" content="The homepage for My Bookstore">

    <!--
        normalize-and-reset.css is a basic CSS reset; useful for starting from ground zero.
        always include this first.
    -->

    <link rel="stylesheet" type="text/css" href="<c:url value="/css/normalize-and-reset.css"/>">

    <!--
        cascading appropriately, we have:

        main.css    --  all things common
        header.css  --  header-specific rules
        footer.css  --  footer-specific rules
        <page>.css  --  page-specific rules
        extras.css  --  extras you may want
    -->
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/main.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/header.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/footer.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/homepage.css"/>">

</head>

<body>

<main>
    <jsp:include page="header.jsp"/>


<section id="homepage">
        <section id="home_left">
            <div id="home_welcome_group">
                <h1>Welcome</h1>
                <p id="home_welcome_message">
                    Knowledge can become trivia unless it informs action in some way.
                    It is our hope that these books will enable and inspire that action.
                </p>
            </div>
        </section>
        <section id="home_right">
            <section id="home_right_top">
                <div id="home_recommendation_group">
                    <h3>Recommended</h3>
                    <h3>books in</h3>
                    <c:set var="randomCategoryName" value="${p.randomCategory.name}"/>
                    <a href="category?category=${randomCategoryName}">
                        <h2 id="home_category_recommendation"><my:capitalize stringArg="${randomCategoryName}"/></h2>
                    </a>
                </div>
            </section>
            <section id="home_right_bottom">
                <c:forEach var="book" items="${p.randomCategoryBooks}">
                    <div class="home_recommended_book">
                        <a href="category?category=${randomCategoryName}">
                            <img src="${p.bookImagePath}<my:imageName bookTitle="${book.title}"/>" class="home_recommended_book_img" alt="${book.title}"/>
                        </a>
                    </div>
                </c:forEach>
            </section>
        </section>

    </section>
    <jsp:include page="footer.jsp"/>
</main>

</body>
</html>
