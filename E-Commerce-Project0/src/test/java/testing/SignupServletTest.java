package testing;

import servlets.SignupServlet;
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
import service.SignupService;

import java.io.IOException;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

class SignupServletTest {

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpServletResponse response;

    @Mock
    private SignupService signupService;

    @InjectMocks
    private SignupServlet signupServlet;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testDoPost_SuccessfulRegistration() throws IOException, ServletException {
        // Mock request parameters
        when(request.getParameter("name")).thenReturn("John Doe");
        when(request.getParameter("email")).thenReturn("john.doe@gmail.com");
        when(request.getParameter("mobileNumber")).thenReturn("1234567890");
        when(request.getParameter("securityQuestion")).thenReturn("Mother's maiden name?");
        when(request.getParameter("answer")).thenReturn("Smith");
        when(request.getParameter("password")).thenReturn("password123");
        when(request.getParameter("role")).thenReturn("buyer");

        // Mock signup service to return true (successful registration)
        when(signupService.registerUser(any(User.class))).thenReturn(true);

        // Execute servlet doPost
        signupServlet.doPost(request, response);

        // Capture and verify redirect URL
        ArgumentCaptor<String> redirectCaptor = ArgumentCaptor.forClass(String.class);
        verify(response).sendRedirect(redirectCaptor.capture());
        String actualRedirectUrl = redirectCaptor.getValue();
        System.out.println("Captured Valid redirect URL: " + actualRedirectUrl);
        // Assert the correct redirect URL for successful registration
        assertEquals("signup.jsp?msg=valid", actualRedirectUrl);
    }

    @Test
    void testDoPost_FailedRegistration() throws IOException, ServletException {
        // Mock request parameters
        when(request.getParameter("name")).thenReturn("Jane Doe");
        when(request.getParameter("email")).thenReturn("jane.doe@example.com");
        when(request.getParameter("mobileNumber")).thenReturn("0987654321");
        when(request.getParameter("securityQuestion")).thenReturn("Pet's name?");
        when(request.getParameter("answer")).thenReturn("Fluffy");
        when(request.getParameter("password")).thenReturn("password456");
        when(request.getParameter("role")).thenReturn("seller");

        // Mock signup service to return false (failed registration)
        when(signupService.registerUser(any(User.class))).thenReturn(false);

        // Execute servlet doPost
        signupServlet.doPost(request, response);

        // Capture and verify redirect URL
        ArgumentCaptor<String> redirectCaptor = ArgumentCaptor.forClass(String.class);
        verify(response).sendRedirect(redirectCaptor.capture());
        String actualRedirectUrl = redirectCaptor.getValue();
        System.out.println("Captured Invalid redirect URL: " + actualRedirectUrl);
        // Assert the correct redirect URL for failed registration
        assertEquals("signup.jsp?msg=invalid", actualRedirectUrl);
    }
}
