function Author(Id, firstName, lastName, speciality) {

    this.getLastName = function () {
        return lastName;
    };

    this.getFirstName = function () {
        return firstName;
    };

    this.getId = function () {
        return Id;
    };

    this.getSpeciality = function () {
        return speciality;
    }

}