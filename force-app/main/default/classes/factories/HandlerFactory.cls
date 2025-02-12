public without sharing class HandlerFactory {
    private Map<SObjectType, Type> handlersBySObjectTypes = new Map<SObjectType, Type>();

    public HandlerFactory(final Map<SObjectType, Type> handlersBySObjectTypes) {
        this.handlersBySObjectTypes = handlersBySObjectTypes == null ? new Map<SObjectType, Type>() : handlersBySObjectTypes;
    }

    public TriggerHandler newInstance(final SObjectType sObjectType) {
        if (sObjectType == null) {
            throw new HandlerFactoryException('SObjectType parameter cannot be null.');
        }

        final Type handlerType = this.handlersBySObjectTypes.get(sObjectType);
        if (handlerType == null) {
            throw new HandlerFactoryException('No handler found for SObjectType: ' + sObjectType.getDescribe().getName());
        }

        return (TriggerHandler) handlerType.newInstance();
    }

    public class HandlerFactoryException extends Exception {
    }
}
