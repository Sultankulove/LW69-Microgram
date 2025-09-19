package kg.attractor.java25.microgram.exceptions;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

//@RestControllerAdvice
@ControllerAdvice
@RequiredArgsConstructor
public class GlobalControllerAdvice {

    @ExceptionHandler(Exception.class)
    public String handleNotFoundException(HttpServletRequest request, Model model){
    model.addAttribute("message", HttpStatus.NOT_FOUND.value());
    model.addAttribute("reason", HttpStatus.NOT_FOUND.getReasonPhrase());
    model.addAttribute("details", request);
    model.addAttribute("status", HttpStatus.NOT_FOUND.value());
    return "errors/error";
    }
}
