<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>

<jsp:useBean id="p" type="viewmodel.ConfirmationViewModel" scope="request"/>

<html>
<head>
    <title>Bookstore Confirmation Page</title>
    <meta charset="utf-8">
    <meta name="description" content="The confirmation page for a bookstore">

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
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/confirmation.css"/>">

</head>

<body>
<main>
    <jsp:include page="header.jsp"/>
    <section id="confirmation_page">
        <div id="confirm_main_content">
            <div id="confirm_message_block">
                <p>Thank you!</p>
                <p>Your confirmation number is: <strong>${p.orderDetails.order.confirmationNumber}</strong></p>
                <c:set var="today" value="${p.orderDetails.order.dateCreated}"/>
                <p><fmt:formatDate type = "both" dateStyle = "long" timeStyle = "long" value="${today}"/> </p>
            </div>

            <h3>SHIPPING & BILLING INFOMATION</h3>
            <table id="confirm_customer_info_table">
                <tr>
                    <td>${p.orderDetails.customer.customerName}</td>
                </tr>
                <tr>
                    <td>${p.orderDetails.customer.address}</td>
                </tr>
                <tr>
                    <td>${p.orderDetails.customer.phone}</td>
                </tr>
                <tr>
                    <td>${p.orderDetails.customer.email}</td>
                </tr>
                <tr>
                    <td>CC number:  <my:fmtCCnumber creditCardNumber="${p.orderDetails.customer.ccNumber}"/></td>
                </tr>
                <tr>
                    <c:set var="expDate" value="${p.orderDetails.customer.ccExpDate}"/>
                    <td>Exp. Date: <fmt:formatDate type = "date" value="${expDate}" pattern="MM/yy"/></td>
                </tr>
            </table>

            <h3>ORDER DETAILS</h3>
            <table id="confirm_order_detail_table">
                <th>Book</th>
                <th>Quantity</th>
                <th>Price</th>
                <c:set var="totalBookCostLessSur" value="0"/>
                <c:forEach var="lineItem" items="${p.orderDetails.lineItems}" varStatus="iterNum">
                    <tr>
                        <td>
                                ${p.orderDetails.books.get(iterNum.index).title}
                        </td>
                        <td>
                                ${lineItem.quantity}
                        </td>
                        <td id="order_table_cost">
                            <my:fmtPrice bookPrice="${lineItem.total}"/>
                            <c:set var="totalBookCostLessSur" value="${lineItem.total + totalBookCostLessSur}"/>
                        </td>
                    </tr>
                </c:forEach>
                <tr>
                    <td> --- Delivery surcharge --- </td>
                    <td> </td>
                    <td id="order_table_surcharge"><my:fmtPrice bookPrice="${p.orderDetails.order.amount - totalBookCostLessSur}"/></td>
                </tr>
                <tr id="order_table_total">
                    <td> Total: </td>
                    <td></td>
                    <td id="order_table_total_num"> <my:fmtPrice bookPrice="${p.orderDetails.order.amount}"/></td>
                </tr>
            </table>
        </div>
    </section>
    <jsp:include page="footer.jsp"/>
</main>
</body>
</html>
