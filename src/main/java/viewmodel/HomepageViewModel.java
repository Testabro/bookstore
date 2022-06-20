package viewmodel;

import business.book.Book;
import business.category.Category;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class HomepageViewModel extends BaseViewModel {

    private Category randomCategory;
    private List<Book> randomCategoryBooks;

    public HomepageViewModel(HttpServletRequest request) {
        super(request);

        //Get and set a random category
        List<Category> categories = categoryDao.findAll();
        Category randCategory = getRandomCategory(categories);
        randomCategory = categoryDao.findByName(randCategory.getName());

        //Get and set a list of random books from random category
        randomCategoryBooks =  getRandomBooks(randomCategory.getName(), 3);
    }

    // Function select an category based on index
    // and return an category
    private Category getRandomCategory(List<Category> list)
    {
        Random rand = new Random();
        Category randCategory = list.get(rand.nextInt(list.size()));

        return randCategory;
    }

    // Function select a group of books category based on index
    // and return an category

    private List<Book> getRandomBooks(String categoryName, int numOfBooks)
    {
        List<Book> randBooks = new ArrayList<>();
        List<Book> books = bookDao.findByCategoryId(categoryDao.findByName(categoryName).getCategoryId());

        Random rand = new Random();

        int counter = 0;
        while(counter < numOfBooks){
            Book randomBook = books.get(rand.nextInt(books.size()));
            if(!randBooks.contains(randomBook)){
                randBooks.add(randomBook);
                counter = counter + 1;
            }else {
                //Do nothing; duplicate book detected
            }
        }

        return randBooks;
    }

    public Category getRandomCategory() { return randomCategory; }
    public List<Book> getRandomCategoryBooks() { return randomCategoryBooks; }
}


