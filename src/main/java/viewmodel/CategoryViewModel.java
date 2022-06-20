package viewmodel;

import business.book.Book;
import business.category.Category;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

public class CategoryViewModel extends BaseViewModel {

    private Category selectedCategory;
    private List<Book> selectedCategoryBooks;

    public CategoryViewModel(HttpServletRequest request) {
        super(request);

        HttpSession session = request.getSession();
        String categoryName = request.getParameter("category");

        if ((isValidName(categoryName))) {
            // get the selected category
            selectedCategory = categoryDao.findByName(categoryName);
            rememberSelectedCategory(session, selectedCategory);
        } else {
            // use the selected category from the session, otherwise use the default category
            if (selectedCategory != null) {
                selectedCategory = recallSelectedCategory(session);
                selectedCategoryBooks = recallSelectedCategoryBooks(session);
            } else {
                selectedCategory = categoryDao.findByCategoryId(1001);
            }
        }
        rememberSelectedCategory(session, selectedCategory);
        rememberSelectedCategoryBooks(session, selectedCategoryBooks);

        // get all products for selected category
        selectedCategoryBooks = bookDao.findByCategoryId(selectedCategory.getCategoryId());
        rememberSelectedCategoryBooks(session, selectedCategoryBooks);
    }

    private boolean isValidName(String name) {
         Category category = categoryDao.findByName(name);

         if (null == category){
             return false;
         } else {
             return true;
         }

    }

    private List<Book> recallSelectedCategoryBooks(HttpSession session) {
        return (List) session.getAttribute("selectedCategoryProducts");
    }

    private void rememberSelectedCategoryBooks(HttpSession session, List<Book> selectedCategoryBooks) {
        session.setAttribute("selectedCategoryProducts", selectedCategoryBooks);
    }

    private Category recallSelectedCategory(HttpSession session) {
        return (Category) session.getAttribute("selectedCategory");
    }

    private void rememberSelectedCategory(HttpSession session, Category selectedCategory) {
        session.setAttribute("selectedCategory", selectedCategory);
    }


    public Category getSelectedCategory() { return selectedCategory; }
    public List<Book> getSelectedCategoryBooks() { return selectedCategoryBooks; }
}
