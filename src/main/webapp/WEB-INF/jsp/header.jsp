<jsp:useBean id="p" scope="request" type="viewmodel.BaseViewModel"/>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header>
    <section id="header_center">
        <div id="header_logo">
            <a href="home">
                <img src="${p.siteImagePath}logo_image.png" id="header_logo_img" alt="Babbage logo"/>
            </a>
        </div>
        <div id="header_logo_text">
            <a href="home">
                <img src="${p.siteImagePath}logo_text.gif" id="header_logo_text_img" alt="Babbage"/>
            </a>
        </div>
    </section>

    <section id="header_right">
        <div id="header_login_and_cart_group">
            <a href="#" id="header_login">
                Login
            </a>
            <a href="cart">
                <div id="header_cart_count_and_cart">
                    <div id="header_cart_icon">
                        <img src="${p.siteImagePath}cart_icon.png" alt="Babbage" id="header_cart_icon_img"/>
                    </div>
                    <div id="cartCount">
                        ${p.cart.numberOfItems}
                    </div>
                </div>
            </a>
        </div>
        <div id="header_navigation_group">
            <div id="header_dropdown">
                <button id="header_dropbtn">
                    <img src="${p.siteImagePath}dropdown_icon_white.png" alt="menu_button" id="header_dropbtn_icon_img"/>
                    Category
                </button>
                <div id="header_dropdown-content">
                    <ul>
                        <c:forEach var="category" items="${p.categories}">
                              <li>
                                <a href="category?category=${category.name}">${category.name}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <form id="header_search_form" type="text">
                <input type="text" name="Search" placeholder="  Search books.." id="header_search_input"/>
            </form>
            <input id="header_search_icon_img" type="image" src="${p.siteImagePath}search_icon.png" alt="search button"/>
        </div>
    </section>
</header>
