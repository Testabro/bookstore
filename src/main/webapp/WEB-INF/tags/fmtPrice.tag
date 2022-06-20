<%@ tag body-content="empty" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ attribute name="bookPrice" rtexprvalue="true" required="true" type="java.lang.Integer" description="price in cents to format" %>


<div align="right"><fmt:formatNumber value="${bookPrice / 100}" type="currency"/></div>



