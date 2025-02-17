@isTest
public without sharing class ExceptionsTest {
    @isTest
    public static void newAuraHandledExceptionTest() {
        // Given
        Exception actualError = null;

        // When
        try {
            insert new List<Account>{ null };
        } catch (Exception error) {
            actualError = Exceptions.newAuraHandledException(error);
        }

        // Then
        Assert.isNotNull(actualError, 'Expected error to not be null');
    }

    @isTest
    public static void getDescribeTest() {
        // Given
        final Lead nullLead = null;
        Exception actualError = null;

        // When
        try {
            insert nullLead;
        } catch (Exception error) {
            actualError = error;
        }
        final Map<String, String> result = Exceptions.getDetails(actualError);

        // Then
        Assert.areEqual(3, result.keySet().size(), 'Expected 4 keys in the result map');
        for (String key : result.keySet()) {
            Assert.isFalse(String.isBlank(result.get(key)), 'Expected value for ' + key + ' to be not empty');
        }
    }

    @isTest
    public static void getDescribeTestNull() {
        // Given
        Exception nullError = null;
        // When
        final Map<String, String> result = Exceptions.getDetails(nullError);
        // Then
        Assert.isNull(result, 'Expected result to be null when error is null');
    }
}
