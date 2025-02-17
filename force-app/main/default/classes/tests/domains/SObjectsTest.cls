@isTest
public without sharing class SObjectsTest {
    @isTest
    public static void getIdFieldValuesTest() {
        // Given
        final Account testAccount = new Account(Id = '001Aq00000TfPRZIA3');
        SObjects testSObjects = new SObjects(new List<SObject>{ testAccount });

        // When
        final Set<Id> result = testSObjects.getIdFieldValues(Account.Id);

        // Then
        Assert.areEqual(new Set<Id>{ testAccount.Id }, result, 'Id field values should match');
    }

    @isTest
    public static void getIdFieldValuesByFieldValueTest() {
        // Given
        final Account testAccount = new Account(Id = '001Aq00000TfPRZIA3', Name = 'Test Account');
        SObjects testSObjects = new SObjects(new List<SObject>{ testAccount });

        // When
        final Set<Id> result = testSObjects.getIdFieldValuesByFieldValue(Account.Id, Account.Name, 'Test Account');

        // Then
        Assert.areEqual(new Set<Id>{ testAccount.Id }, result, 'Id field values should match');
    }
}
