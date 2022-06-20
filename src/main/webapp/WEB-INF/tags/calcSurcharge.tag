<%@ tag body-content="empty" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ attribute name="totalAmount" rtexprvalue="true" required="true" type="java.lang.Integer" description="total order amount" %>
<%@ attribute name="orderItems" rtexprvalue="true" required="true" type="java.util.Collections" description="list of book costs" %>


Total amount == ${totalAmount}




