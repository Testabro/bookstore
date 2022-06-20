package controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "BookstoreServlet",
        loadOnStartup = 1)
public class BookstoreServlet extends HttpServlet {

    // Forwards the request to [userPath].jsp
    protected void forwardToJsp(HttpServletRequest request,
                                HttpServletResponse response, String userPath) {
        String url = "/WEB-INF/jsp" + userPath + ".jsp";
        try {
            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
