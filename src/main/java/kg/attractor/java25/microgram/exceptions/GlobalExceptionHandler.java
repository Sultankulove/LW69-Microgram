package kg.attractor.java25.microgram.exceptions;

import jakarta.persistence.EntityNotFoundException;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(AccessDeniedException.class)
    public String handle403(AccessDeniedException ex, RedirectAttributes ra) {
        ra.addFlashAttribute("error", "Недостаточно прав");
        return "redirect:/";
    }

    @ExceptionHandler(EntityNotFoundException.class)
    public String handle404(EntityNotFoundException ex, RedirectAttributes ra) {
        ra.addFlashAttribute("error", "Не найдено");
        return "redirect:/";
    }
}
