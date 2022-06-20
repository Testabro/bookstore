<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>

<jsp:useBean id="p" scope="request" type="viewmodel.CheckoutViewModel"/>

<!doctype html>
<html>
<head>
    <title>My Bookstore - Category</title>
    <meta charset="utf-8">
    <meta name="description" content="The category page for My Bookstore">

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
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/checkout.css"/>">
</head>

<body class="home">
<main>
    <jsp:include page="header.jsp"/>
    <div id="checkout_page">
        <section id="checkoutMain">
            <div id="checkout_left">
                <h3>ACCOUNT DETAILS</h3>

                <div id="checkoutFormErrors">
                    <c:if test="${p.hasValidationError}">
                        <c:if test="${p.customerForm.hasNameError}">
                            ${p.customerForm.nameErrorMessage}<br>
                        </c:if>
                        <c:if test="${p.customerForm.hasAddressError}">
                            ${p.customerForm.addressErrorMessage}<br>
                        </c:if>
                        <c:if test="${p.customerForm.hasPhoneError}">
                            ${p.customerForm.phoneErrorMessage}<br>
                        </c:if>
                        <c:if test="${p.customerForm.hasEmailError}">
                            ${p.customerForm.emailErrorMessage}<br>
                        </c:if>
                        <c:if test="${p.customerForm.hasCcNumberError}">
                            ${p.customerForm.ccNumberErrorMessage}<br>
                        </c:if>
                        <c:if test="${p.customerForm.hasCcExpDateError}">
                            ${p.customerForm.ccExpDateErrorMessage}<br>
                        </c:if>
                    </c:if>
                    <c:if test="${p.hasTransactionError}">
                        Transactions have not been implemented yet.<br>
                    </c:if>
                </div>
                <div id="checkoutFormAndInfo">
                    <div id="checkoutFormBox">
                        <form id="checkoutForm" action="<c:url value='checkout'/>" method="post">
                            <table id="account_info_table">
                                <tr>
                                    <td>
                                        <label for="name">Name</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input id="name" class="textField" type="text" size="70" maxlength="45" name="name"
                                               value="${p.customerForm.name}"><br>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label for="address">Street address</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input id="address" class="textField" type="text" size="70" maxlength="125" name="address"
                                               value="${p.customerForm.address}"><br>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label for="phone">Phone number</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input id="phone" class="textField" size="70" maxlength="45" name="phone"
                                               value="${p.customerForm.phone}"><br>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label for="email">E-Mail</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input id="email" class="textField" size="70" maxlength="45" name="email"
                                               value="${p.customerForm.email}"><br>
                                    </td>
                                </tr>
                            </table>

                            <h3>PAYMENT</h3>
                            <table id="payment_table">
                                <tr>
                                    <td>
                                        <label for="ccNumber">Credit card number</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input id="ccNumber" class="textField" size="70" maxlength="45" name="ccNumber"><br>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <label> Expiration date</label>
                                    </td>
                                </tr>
                                    <tr>
                                        <td>
                                            <label>
                                                <select class="selectMenu" name="ccMonth">
                                                    <c:set var="montharr"
                                                           value="${['January','February','March','April','May','June','July','August','September','October','November','December']}"/>
                                                    <c:forEach begin="1" end="12" var="month">
                                                        <option value="${month}"
                                                                <c:if test="${p.customerForm.ccMonth eq month}">selected</c:if>>
                                                                ${month}-${montharr[month - 1]}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </label>
                                            <label>
                                                <select class="selectMenu" name="ccYear">
                                                    <c:forEach begin="2019" end="2027" var="year">
                                                        <option value="${year}" <c:if test="${p.customerForm.ccYear eq year}">selected</c:if>>
                                                                ${year}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </label>
                                        </td>
                                    </tr>
                            </table>
                            <input id="checkout_chk_out_button" type="submit" value="PLACE ORDER">
                        </form>
                        <%-- Validate form input via script --%>
                        <script src="<c:url value="/js/checkout_validate.js"/>" type="text/javascript"></script>
                    </div>
                </div>
            </div>

            <div id="checkout_right">
                <h3>ORDER SUMMARY</h3>
                <hr>
                <table id="checkout_summary_table">
                    <tr>
                        <td>
                            <p>Item Subtotal</p>
                        </td>
                        <td>
                            <my:fmtPrice bookPrice="${p.cart.subtotal}"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p>Surcharge</p>
                        </td>
                        <td>
                            <my:fmtPrice bookPrice="${p.cart.surcharge}"/>
                        </td>
                    </tr>
                </table>
                <br><br>
                <hr>
                <table>
                    <tr>
                        <td>
                            <h3 id="checkout_total_text">Total</h3>
                        </td>
                        <td>
                            <h3 id="checkout_total_num"><my:fmtPrice bookPrice="${p.cart.subtotal + p.cart.surcharge}"/></h3>
                        </td>
                    </tr>
                </table>
            </div>
        </section>
    </div>

    <jsp:include page="footer.jsp"/>
</main>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="<c:url value="/js/jquery.validate.js"/>" type="text/javascript"></script>
<script src="<c:url value="/js/additional-methods.js"/>" type="text/javascript"></script>
</body>
</html>
