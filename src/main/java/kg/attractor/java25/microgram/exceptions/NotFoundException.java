package kg.attractor.java25.microgram.exceptions;

import java.util.NoSuchElementException;

public class NotFoundException extends NoSuchElementException {
    public NotFoundException(String prefix) { super(prefix + " not found"); }
}