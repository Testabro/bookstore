package controller;

import business.ApplicationContext;
import business.cart.ShoppingCart;
import business.customer.CustomerForm;
import business.order.OrderDetails;
import business.order.OrderService;
import viewmodel.CheckoutViewModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "Checkout",
        urlPatterns = {"/checkout"})
public class CheckoutServlet extends BookstoreServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");

        if(null != cart){
            request.setAttribute("p", new CheckoutViewModel(request));
            forwardToJsp(request, response, "/checkout");
        }else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");

        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String ccNumber = request.getParameter("ccNumber");
        String ccMonth = request.getParameter("ccMonth");
        String ccYear = request.getParameter("ccYear");

        //CustomerForm customerForm = new CustomerForm(name, address, phone, email, ccNumber, ccMonth, ccYear);
        CustomerForm customerForm = new CustomerForm(name, address, phone, email, ccNumber, ccMonth, ccYear);
        session.setAttribute("customerForm", customerForm);

        //Set some more session variables; Allow ccMonth and ccYear field to persist even when navigated away from
        session.setAttribute("ccMonth", ccMonth);
        session.setAttribute("ccYear", ccYear);


        // In the instance that that checkout page is bookmarked or navigated to via browser with no items
        //send to cart page
        if (cart.getItems().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        //Redirect to checkout page to allow errors to be corrected by user
        if (customerForm.getHasFieldError()) {
            session.setAttribute("validationError", Boolean.TRUE);
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }

        //If all goes well then create a order service to handle the order details
        //and commit to the database if successful

        OrderService orderService = ApplicationContext.INSTANCE.getOrderService();

        long orderId = orderService.placeOrder(customerForm, cart);
        if (orderId == 0) {
            session.setAttribute("transactionError", Boolean.TRUE);
            response.sendRedirect(request.getContextPath() + "/category");
        } else {
            cart.clear();
            OrderDetails orderDetails = (OrderDetails) orderService.getOrderDetails(orderId);
            session.setAttribute("orderDetails", orderDetails);
            response.sendRedirect(request.getContextPath() + "/confirmation");
            return;
        }
    }
}