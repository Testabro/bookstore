<!-- this is /WEB-INF/jsp/category.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>

<jsp:useBean id="p" type="viewmodel.CategoryViewModel" scope="request"/>

<!doctype html>
<html>
<head>
    <title>Bookstore Category Page</title>
    <meta charset="utf-8">
    <meta name="description" content="The category page for a bookstore">

    <!--
        normalize-and-reset.css.css is a basic CSS reset; useful for starting from ground zero.
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
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/category.css"/>">

</head>

<body>
<main>
    <jsp:include page="header.jsp"/>
    <section id="category_page">
        <section id="category_left">
            <nav id="category_navigation_pane">
                <ul id="category_navigation_options">
                    <li id="category_navigation_pane_title">
                        <h2>Category</h2>
                    </li>
                    <c:forEach var="category" items="${p.categories}">
                        <c:choose>
                            <c:when test="${category.name == p.selectedCategory.name}">
                                <li id="selected_category">
                                    <my:capitalize stringArg="${p.selectedCategory.name}"/>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <a href="category?category=${category.name}">
                                    <li class="unselected_category">
                                        <h6>${category.name}</h6>
                                    </li>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </ul>
            </nav>
        </section>
        <section id="category_right">
            <c:forEach var="book" items="${p.selectedCategoryBooks}">
                <div class="book">
                    <div class="book_img_holder">
                        <div>
                            <! -- Check if book is readable online and display button if true -->
                            <c:if test="${book.getisPublic() == true}">
                                <button title="read_button" class="read_button">Read</button>
                            </c:if>
                        </div>
                        <a href="#">
                            <img src="${p.bookImagePath}<my:imageName bookTitle="${book.title}"/>" class="book_img" alt="${book.title}"/>
                        </a>
                    </div>
                    <div class="book_title_group">
                        <div id="book_title_group_name">
                            <h4>${book.title}</h4>
                            <h5>${book.author}</h5>
                        </div>
                        <div class="book_buttons">
                            <table>
                                <tr>
                                    <td>
                                        <h7><my:fmtPrice bookPrice="${book.price}"/></h7>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <button title="addToCart_button" class="addToCartButton"
                                                data-book-id="${book.bookId}"
                                                data-action="add">
                                            Add to Cart
                                        </button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </section>
    </section>
    <jsp:include page="footer.jsp"/>
</main>
<script src="<c:url value="/js/ajax-functions.js"/>" type="text/javascript"></script>
<script>
    var addToCartButtons = document.getElementsByClassName("addToCartButton");
    for (var i = 0; i < addToCartButtons.length; i++) {
        addToCartButtons[i].addEventListener("click", function(event) {
            addToCartEvent(event.target) });
    }

    function addToCartEvent(button) {
        var data = {"bookId":button.dataset.bookId,
            "action":button.dataset.action
        };
        ajaxPost('cart', data, function(text, xhr) {
        addToCartCallback(text, xhr)
        });
    }

    function addToCartCallback(responseText, xhr) {
        var cartCount = JSON.parse(responseText).cartCount;
        document.getElementById('cartCount').textContent = '' + cartCount;
    }
</script>
</body>
</html>
