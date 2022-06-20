<%@ tag body-content="empty" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<%@ attribute name="bookTitle" rtexprvalue="true" required="true" type="java.lang.String" description="Text to search for book type" %>

<c:set var="formattedTitle">
    ${fn:replace(bookTitle, ":", "")}
</c:set>

<c:set var="formattedTitle">
    ${fn:toLowerCase(formattedTitle)}
</c:set>

<c:set var="formattedTitle">
    ${fn:replace(formattedTitle, " ", "_")}
</c:set>

<c:set var="formattedTitle">
    ${fn:replace(formattedTitle, "\'", "")}
</c:set>

<c:set var="formattedTitle">
    ${fn:replace(formattedTitle, "-", "")}
</c:set>

<c:set var="formattedTitle">
    ${fn:replace(formattedTitle, ",", "")}
</c:set>

${formattedTitle}.gif


