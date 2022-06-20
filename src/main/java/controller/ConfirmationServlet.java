package controller;

import business.order.OrderDetails;
import viewmodel.ConfirmationViewModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ConfirmationServlet", description = "Confirmation page servlet",urlPatterns = "/confirmation")
public class ConfirmationServlet extends BookstoreServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OrderDetails orderDetails = (OrderDetails) request.getSession().getAttribute("orderDetails");
        if(null == orderDetails) {
            response.sendRedirect(request.getContextPath() + "/cart");
        }
        /*Forward to confirmation page */
        request.setAttribute("p", new ConfirmationViewModel(request));
        String userPath = "/confirmation";
        forwardToJsp(request, response, userPath);
    }

}
