package business.order;

import business.ApplicationContext;
import business.book.Book;

public class LineItem {

    private long bookId;
    private long customerOrderId;
    private int quantity;

    public LineItem(long customerOrderId, long bookId, int quantity) {
        this.bookId = bookId;
        this.customerOrderId = customerOrderId;
        this.quantity = quantity;
    }

    public long getBookId() {
        return bookId;
    }

    public long getCustomerOrderId() {
        return customerOrderId;
    }

    public int getTotal() {
        int price = ApplicationContext.INSTANCE.getBookDao().findByBookId(bookId).getPrice();
        return quantity * price;
    }

    public int getQuantity() { return quantity; }

    @Override
    public String toString() {
        return "LineItem{" +
                "customerOrderId=" + customerOrderId +
                ", bookId=" + bookId +
                ", quantity=" + quantity +
                '}';
    }
}