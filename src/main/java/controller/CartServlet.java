package controller;

import business.ApplicationContext;
import business.book.Book;
import business.cart.ShoppingCart;
import viewmodel.CartViewModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.HttpConstraint;
import javax.servlet.annotation.ServletSecurity;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CartServlet", description = "Cart servlet",urlPatterns = "/cart")
@ServletSecurity(@HttpConstraint(transportGuarantee = ServletSecurity.TransportGuarantee.CONFIDENTIAL))
public class CartServlet extends BookstoreServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        ShoppingCart cart = (ShoppingCart) request.getSession().getAttribute("cart");

        //handle ajax requests
        boolean isAjaxRequest =
                "XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With"));
        if (isAjaxRequest) {
            if ("add".equals(action)) {
                String bookIdText = request.getParameter("bookId");
                long bookId = Long.parseLong(bookIdText);
                Book book = ApplicationContext.INSTANCE.getBookDao().findByBookId(bookId);
                cart.addItem(book);
            }else if ("update".equals(action)){
                // update the book quantity in the cart
                String bookIdText = request.getParameter("bookId");
                long bookId = Long.parseLong(bookIdText);
                Book book = ApplicationContext.INSTANCE.getBookDao().findByBookId(bookId);
                String updateNumValueText = request.getParameter("updateValue");
                int updateNumValue = Integer.parseInt(updateNumValueText);
                cart.update(book, updateNumValue);
            }
            String jsonString = "{\"cartCount\": " + cart.getNumberOfItems() + "}";
            response.setContentType("application/json");
            response.getWriter().write(jsonString);
            response.flushBuffer();
            return;
        }

        if ("remove".equals(action)){
            // Remove the book from the cart
            String bookIdText = request.getParameter("bookId");
            long bookId = Long.parseLong(bookIdText);
            Book book = ApplicationContext.INSTANCE.getBookDao().findByBookId(bookId);

            cart.update(book, 0);
            response.sendRedirect(request.getContextPath() + "/cart");
        }

        if (null == action) {
            response.sendRedirect(request.getContextPath() + "/category");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /*Forward to category page */
        request.setAttribute("p", new CartViewModel(request));
        String userPath = "/cart";
        forwardToJsp(request, response, userPath);
    }

}
