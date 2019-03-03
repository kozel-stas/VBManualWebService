package core.model;

import javax.annotation.concurrent.Immutable;
import java.util.Objects;

@Immutable
public class Author {

    private final String id;
    private final String firstName;
    private final String lastName;
    private final String speciality;

    public Author(String id, String firstName, String lastName, String speciality) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.speciality = speciality;
    }

    public String getId() {
        return id;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getSpeciality() {
        return speciality;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj instanceof Author) {
            Author that = (Author) obj;
            return Objects.equals(id, that.id);
        }
        return false;
    }

    @Override
    public String toString() {
        return "Author={id=" + id +
                ", firstName=" + firstName +
                ", lastName=" + lastName +
                ", speciality=" + speciality +
                "}";
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

}
