<%@ tag body-content="empty" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="creditCardNumber" rtexprvalue="true" required="true" type="java.lang.String" description="credit card info for display" %>

<c:set var="fmtCreditCardNumber" value="${fn:trim(creditCardNumber)}"/>
<c:set var="ccNumberLength" value="${fn:length(fmtCreditCardNumber)}"/>
<c:set var="ccNumberVisableLen" value="4"/>
<c:set var="ccNumberHiddenLen" value="${ccNumberLength - ccNumberVisableLen}"/>

<c:set var="hiddenStr" value="${fn:substring(fmtCreditCardNumber, 0, ccNumberHiddenLen)}"/>
<c:set var="visibleStr" value="${fn:substring(fmtCreditCardNumber,ccNumberHiddenLen, ccNumberLength)}"/>

<c:set var="hiddenStr">
    ${fn:replace(hiddenStr, "0", "*")}
</c:set>
<c:set var="hiddenStr">
    ${fn:replace(hiddenStr, "1", "*")}
</c:set>
<c:set var="hiddenStr">
    ${fn:replace(hiddenStr, "2", "*")}
</c:set>
<c:set var="hiddenStr">
    ${fn:replace(hiddenStr, "3", "*")}
</c:set>
<c:set var="hiddenStr">
    ${fn:replace(hiddenStr, "4", "*")}
</c:set>
<c:set var="hiddenStr">
    ${fn:replace(hiddenStr, "5", "*")}
</c:set>
<c:set var="hiddenStr">
    ${fn:replace(hiddenStr, "6", "*")}
</c:set>
<c:set var="hiddenStr">
    ${fn:replace(hiddenStr, "7", "*")}
</c:set>
<c:set var="hiddenStr">
    ${fn:replace(hiddenStr, "8", "*")}
</c:set>
<c:set var="hiddenStr">
    ${fn:replace(hiddenStr, "9", "*")}
</c:set>

${hiddenStr}${visibleStr}