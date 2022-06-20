<!-- this is /WEB-INF/jsp/cart.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>

<jsp:useBean id="p" type="viewmodel.CartViewModel" scope="request"/>

<!doctype html>
<html>
<head>
    <title>Bookstore Cart Page</title>
    <meta charset="utf-8">
    <meta name="description" content="The cart page for a bookstore">

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
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/cart.css"/>">
</head>

<body>
<main>
    <jsp:include page="header.jsp"/>

     <section id="cart_page_container">
        <div id="cart_top">
            <h3 id="cart_books_header_title">SHOPPING CART </h3><p id="titleBannerNumItems">(${p.cart.numberOfItems} items)</p>
        </div>
        <div id="cart_content_container">
            <div id="cart_page_left">
                <c:forEach var="book" items="${p.cart.items}">
                <div class="cart_left_content">
                    <img src="${p.bookImagePath}<my:imageName bookTitle="${book.book.title}"/>" class="cart_book_img" alt="book"/>
                    <table class="cart_book_table">
                        <tr class="cart_table_row_book">
                            <td class="cart_book_title" colspan="3">
                                <h3>${book.book.title}</h3>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                Item Number
                            </th>
                            <th>
                                Price
                            </th>
                            <th>
                                Quantity
                            </th>
                        </tr>
                        <tr>
                            <td>
                                    ${book.bookId}
                            </td>
                            <td>
                                <my:fmtPrice bookPrice="${book.book.price}"/>
                            </td>
                            <td class="cart_update_group">
                                <select class="cart_book_update_drop_down" onchange="updateBookValue(this.value)">
                                    <c:forEach var="number" begin="1" end="${p.cart.maxQuantity}">
                                        <option value="${number}" <c:if test="${number == book.quantity}">selected</c:if>>
                                                ${number}
                                        </option>
                                    </c:forEach>
                                </select>
                                <button class="updateButton"
                                        data-book-id="${book.bookId}"
                                        data-action="update">
                                    Update
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <form action="cart" method="post">
                                    <input type="hidden" name="bookId" value="${book.bookId}"/>
                                    <input type="hidden" name="action" value="remove"/>
                                    <input class="bookRemoveButton" type="submit" name="submit" value="Remove"/>
                                </form>
                            </td>
                        </tr>
                    </table>
                </div>
                </c:forEach>
            </div>

            <div id="cart_page_right">
                <h3>ORDER SUMMARY</h3>
                <hr>
                <table id="cart_summary_table">
                    <tr>
                        <th>
                            Item Subtotal
                        </th>
                        <td>
                            <my:fmtPrice bookPrice="${p.cart.subtotal}"/>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Surcharge
                        </th>
                        <td>
                            <!-- Display in a empty cart -->
                            <c:if test="${p.cart.numberOfItems == 0}">free</c:if>
                            <!-- Display in a non-empty cart -->
                            <c:if test="${p.cart.numberOfItems != 0}"><my:fmtPrice bookPrice="${p.cart.surcharge}"/></c:if>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Estimated Total
                        </th>
                        <td>
                            <!-- Display in a empty cart -->
                            <c:if test="${p.cart.numberOfItems == 0}"><my:fmtPrice bookPrice="0"/></c:if>
                            <!-- Display in a non-empty cart -->
                            <c:if test="${p.cart.numberOfItems != 0}"><my:fmtPrice bookPrice="${p.cart.subtotal + p.cart.surcharge}"/></c:if>
                        </td>
                    </tr>
                </table>

                <%-- checkout helper --%>
                <c:if test="${p.cart.numberOfItems > 0}">
                    <c:url var="proceed_to_checkout_url" value="checkout"/>
                    <a href="${proceed_to_checkout_url}">
                        <button id="cart_chk_out_button">
                            Proceed to checkout
                        </button>
                    </a>
                </c:if>

                <%-- continue shopping helper --%>
                <c:set var="continue_shopping_location">
                    <c:choose>
                        <%-- if 'selectedCategory' session object exists, send user to previously viewed category --%>
                        <c:when test="${p.hasSelectedCategory != false}">
                            category
                        </c:when>
                        <%-- otherwise send user to welcome page --%>
                        <c:otherwise>
                            home
                        </c:otherwise>
                    </c:choose>
                </c:set>

                <c:url var="continue_shopping_url" value="${continue_shopping_location}"/>
                <a href="${continue_shopping_url}">
                    <button id="cart_cont_shop_button">
                        Continue shopping
                    </button>
                </a>
            </div>
        </div>
    </section>
    <jsp:include page="footer.jsp"/>
</main>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="<c:url value="/js/ajax-functions.js"/>" type="text/javascript"></script>
<script>
    var bookNumUpdate = 1;
    var updateButtons = document.getElementsByClassName("updateButton");
    for (var i = 0; i < updateButtons.length; i++) {
        updateButtons[i].addEventListener("click", function(event) {
            updateCartEvent(event.target) });
    }

    function updateBookValue(selectedNumber) {
        bookNumUpdate = selectedNumber;
    }

    function updateCartEvent(button) {
        var data = {"bookId":button.dataset.bookId, "updateValue":bookNumUpdate,
            "action":button.dataset.action
        };
        ajaxPost('cart', data, function(text, xhr) {
            updateCartCallback(text, xhr)
        });
    }

    function updateCartCallback(responseText, xhr) {
        //alert('Response text: ' + responseText + '; Ready state is ' + xhr.readyState);
        var cartCount = JSON.parse(responseText).cartCount;
        document.getElementById('cartCount').textContent = '' + cartCount;
        document.getElementById('titleBannerNumItems').textContent = '(' + cartCount + ' items)';

    }
</script>
</body>
</html>
