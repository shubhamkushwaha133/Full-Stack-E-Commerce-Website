package testing;


import servlets.LoginServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import service.LoginService;

import java.io.IOException;

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

class LoginServletTest {

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpServletResponse response;

    @Mock
    private HttpSession session;

    @Mock
    private LoginService loginService;

    @InjectMocks
    private LoginServlet loginServlet;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testDoPost_ValidSellerCredentials() throws IOException, ServletException {
        // Mock request parameters
        when(request.getParameter("email")).thenReturn("seller@gmail.com");
        when(request.getParameter("password")).thenReturn("password123");
        when(request.getSession()).thenReturn(session);

        // Mock user authentication
        User user = new User();
        user.setEmail("seller@gmail.com");
        user.setRole("seller");
        when(loginService.authenticateUser(anyString(), anyString())).thenReturn(user);

        // Debugging
        System.out.println("Running testDoPost_ValidSellerCredentials");

        // Execute servlet doPost
        loginServlet.doPost(request, response);

        // Capture and verify redirect URL
        ArgumentCaptor<String> redirectCaptor = ArgumentCaptor.forClass(String.class);
        verify(response).sendRedirect(redirectCaptor.capture());
        String actualRedirectUrl = redirectCaptor.getValue();

        // Debugging
        System.out.println("Captured redirect URL: " + actualRedirectUrl);

        // Assert the correct redirect URL for seller
        assertEquals("admin/adminHome.jsp", actualRedirectUrl);

        // Verify session attributes
        verify(session).setAttribute("email", "seller@gmail.com");
    }

    @Test
    void testDoPost_ValidBuyerCredentials() throws IOException, ServletException {
        // Mock request parameters
        when(request.getParameter("email")).thenReturn("buyer@gmail.com");
        when(request.getParameter("password")).thenReturn("password123");
        when(request.getSession()).thenReturn(session);

        // Mock user authentication
        User user = new User();
        user.setEmail("buyer@gmail.com");
        user.setRole("buyer");
        when(loginService.authenticateUser(anyString(), anyString())).thenReturn(user);

        // Debugging
        System.out.println("Running testDoPost_ValidBuyerCredentials");

        // Execute servlet doPost
        loginServlet.doPost(request, response);

        // Capture and verify redirect URL
        ArgumentCaptor<String> redirectCaptor = ArgumentCaptor.forClass(String.class);
        verify(response).sendRedirect(redirectCaptor.capture());
        String actualRedirectUrl = redirectCaptor.getValue();

        // Debugging
        System.out.println("Captured redirect URL: " + actualRedirectUrl);

        // Assert the correct redirect URL for buyer
        assertEquals("home.jsp", actualRedirectUrl);

        // Verify session attributes
        verify(session).setAttribute("email", "buyer@gmail.com");
    }

    @Test
    void testDoPost_InvalidCredentials() throws IOException, ServletException {
        // Mock request parameters
        when(request.getParameter("email")).thenReturn("invalid@example.com");
        when(request.getParameter("password")).thenReturn("wrongpassword");

        // Mock user authentication to return null
        when(loginService.authenticateUser(anyString(), anyString())).thenReturn(null);

        // Debugging
        System.out.println("Running testDoPost_InvalidCredentials");

        // Execute servlet doPost
        loginServlet.doPost(request, response);

        // Capture and verify redirect URL
        ArgumentCaptor<String> redirectCaptor = ArgumentCaptor.forClass(String.class);
        verify(response).sendRedirect(redirectCaptor.capture());
        String actualRedirectUrl = redirectCaptor.getValue();

        // Debugging
        System.out.println("Captured redirect URL: " + actualRedirectUrl);

        // Assert the correct redirect URL for invalid credentials
        assertEquals("login.jsp?msg=notexist", actualRedirectUrl);
    }
}
