@isTest
public without sharing class SetsTest {
    @isTest
    public static void isNullOrEmptyTestObjects() {
        // When
        final Boolean actual = Sets.isNullOrEmpty(new Set<Object>());
        // Then
        Assert.isTrue(actual, 'actual should be true');
    }

    @isTest
    public static void isNullOrEmptyTestIds() {
        // When
        final Boolean actual = Sets.isNullOrEmpty(new Set<Id>());
        // Then
        Assert.isTrue(actual, 'actual should be true');
    }

    @isTest
    public static void isNullOrEmptyTestFields() {
        // When
        final Boolean actual = Sets.isNullOrEmpty(new Set<SObjectField>());
        // Then
        Assert.isTrue(actual, 'actual should be true');
    }

    @isTest
    public static void isNullOrEmptyTestStrings() {
        // When
        final Boolean actual = Sets.isNullOrEmpty(new Set<String>());
        // Then
        Assert.isTrue(actual, 'actual should be true');
    }

    @isTest
    public static void toStringTest() {
        // When
        final String actual = Sets.toString(new Set<Id>{ '001Aq00000TfPRZIA3' });
        // Then
        Assert.areEqual('(\'001Aq00000TfPRZIA3\')', actual, 'actual should be correct');
    }
}
