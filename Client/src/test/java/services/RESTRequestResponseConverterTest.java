package services;

import model.Author;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

public class RESTRequestResponseConverterTest {

    private RESTRequestResponseConverter restRequestResponseConverter;

    @Before
    public void beforeUp() {
        restRequestResponseConverter = new RESTRequestResponseConverter();
    }

    @Test
    public void convertTest() {
        Assert.assertEquals(1, restRequestResponseConverter.getArticleTotalNumber("{\"articleTotalNumber\":1}"));
        Assert.assertEquals(1, restRequestResponseConverter.getAuthorTotalNumber("{\"authorTotalNumber\":1}"));
        Assert.assertEquals(1, restRequestResponseConverter.getTopicTotalNumber("{\"topicTotalNumber\":1}"));
        Assert.assertEquals(new Author("1", "firstName", "lastName", "speciality"), restRequestResponseConverter.convertToAuthor("{\"author\":{\"firstName\":\"firstName\",\"lastName\":\"lastName\",\"speciality\":\"speciality\",\"id\":\"1\"}}"));
    }

}
