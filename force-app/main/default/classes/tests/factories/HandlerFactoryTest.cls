@isTest
public without sharing class HandlerFactoryTest {
    @isTest
    public static void newInstanceTest() {
        HandlerFactory factory = new HandlerFactory(new Map<SObjectType, Type>{ Schema.Account.SObjectType => TriggerHandler.class });
        // When
        final TriggerHandler handler = (TriggerHandler) factory.newInstance(Schema.Account.SObjectType);
        // Then
        Assert.isNotNull(handler, 'handler should not be null');
    }

    @isTest
    public static void newInstanceTestException() {
        // Given
        HandlerFactory factory = new HandlerFactory(new Map<SObjectType, Type>{});
        Exception actualError;
        // When
        try {
            factory.newInstance(Schema.Account.SObjectType);
        } catch (HandlerFactory.HandlerFactoryException error) {
            actualError = error;
        }

        // Then
        Assert.isNotNull(actualError, 'e should not be null');
    }
}
