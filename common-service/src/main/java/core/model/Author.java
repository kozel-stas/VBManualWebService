package core.model;

import java.util.Objects;

public class Author {

    private String id;
    private String firstName;
    private String lastName;
    private String speciality;

    public Author(String id, String firstName, String lastName, String speciality) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.speciality = speciality;
    }

    public Author(){

    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setSpeciality(String speciality) {
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
