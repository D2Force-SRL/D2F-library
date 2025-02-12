/**
 * @description Domain Factory class
 * @author dmitrii.dronov@d2force.com
 * @group domains
 * @version 1.0
 * @see Objects
 */
public without sharing class DomainFactory {
    private final Map<SObjectType, Type> domainConstructorsBySObjectTypes;

    /**
     * @description Constructor
     * @param domainConstructorsBySObjectTypes - a map of domain constructors by sObject types
     */
    public DomainFactory(Map<SObjectType, Type> domainConstructorsBySObjectTypes) {
        this.domainConstructorsBySObjectTypes = domainConstructorsBySObjectTypes == null ? new Map<SObjectType, Type>() : domainConstructorsBySObjectTypes;
    }

    /**
     * @description Method to create an instance of a domain
     * @param sObjectType - sObject type
     * @param objects - list of objects
     * @return an instance of a domain
     */
    public Object newInstance(final SObjectType sObjectType, final List<Object> objects) {
        if (sObjectType == null) {
            throw new DomainFactoryException('SObjectType parameter cannot be null.');
        }

        final Type domainConstructorType = this.domainConstructorsBySObjectTypes.get(sObjectType);
        if (domainConstructorType == null) {
            throw new DomainFactoryException('No domain constructor found for SObjectType: ' + sObjectType.getDescribe().getName());
        }

        Objects.IDomainConstructor domainConstructor = (Objects.IDomainConstructor) domainConstructorType.newInstance();
        return domainConstructor.newInstance(objects);
    }

    /**
     * @description Exception class for domain factory
     */
    public class DomainFactoryException extends Exception {}
}