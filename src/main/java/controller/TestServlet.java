package controller;

import business.ApplicationContext;
import business.book.Book;
import business.book.BookDao;
import business.category.Category;
import business.category.CategoryDao;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "Test", urlPatterns = "/test")
public class TestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String defaultCategory = "computer-science";
        String selectedCategoryName = request.getParameter("category");
        request.setAttribute("selectedCategoryName", selectedCategoryName);
        if (selectedCategoryName == null) {
            selectedCategoryName = defaultCategory;
            request.setAttribute("selectedCategoryName", defaultCategory);
        }

        CategoryDao categoryDao = ApplicationContext.INSTANCE.getCategoryDao();
        BookDao bookDao = ApplicationContext.INSTANCE.getBookDao();

        //use cat-name to get cat-object using find by name method from category dao
        Category category = categoryDao.findByName(selectedCategoryName);
        //get category id from from category object using get method
        long categoryId = category.getCategoryId();
        //get selected -book-list using find-by-cat-id method from book dao
        List<Book> selectedCategoryBookList = bookDao.findByCategoryId(categoryId);
        //set book-list attribute
        request.setAttribute("selectedCategoryBookList", selectedCategoryBookList);

        String userPath = "/test";
        String url = "WEB-INF/jsp" + userPath + ".jsp";
        //Use the url to get the request dispatcher from request
        RequestDispatcher requestDispatcher = request.getRequestDispatcher(url);
        //then call the forward method, passing in the request and response objects
        requestDispatcher.forward(request, response);


    }
}
