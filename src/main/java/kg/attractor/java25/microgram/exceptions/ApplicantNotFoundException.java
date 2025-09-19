package kg.attractor.java25.microgram.exceptions;

public class ApplicantNotFoundException extends NotFoundException {
    public ApplicantNotFoundException() {
        super("applicant not found");
    }
}
