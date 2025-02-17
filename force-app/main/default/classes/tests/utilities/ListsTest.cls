@isTest
public without sharing class ListsTest {
    @isTest
    public static void isNullOrEmptyTestNull() {
        // When
        final Boolean actual = Lists.isNullOrEmpty(null);
        // Then
        Assert.isTrue(actual, 'actual should be true');
    }

    @isTest
    public static void isNullOrEmptyTestEmpty() {
        // When
        final Boolean actual = Lists.isNullOrEmpty(new List<Object>());
        // Then
        Assert.isTrue(actual, 'actual should be true');
    }

    @isTest
    public static void toStringsTest() {
        // When
        final List<String> actual = Lists.toStrings(new List<SObjectField>{ Schema.Account.Name });
        // Then
        Assert.areEqual(new List<String>{ 'Name' }, actual, 'actual should be correct');
    }
}
