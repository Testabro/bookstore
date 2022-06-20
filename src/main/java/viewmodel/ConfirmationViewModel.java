package viewmodel;

import business.order.OrderDetails;

import javax.servlet.http.HttpServletRequest;


public class ConfirmationViewModel extends BaseViewModel{

    private OrderDetails orderDetails;

    public ConfirmationViewModel(HttpServletRequest request) {
        super(request);

        //Get the order details from session
        OrderDetails sessionOrderDetails = (OrderDetails) session.getAttribute("orderDetails");
        orderDetails = sessionOrderDetails;
    }
    public OrderDetails getOrderDetails() { return orderDetails; }
}