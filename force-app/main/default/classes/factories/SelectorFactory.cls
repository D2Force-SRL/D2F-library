/**
 * @description Class to create an instance of a selector
 * @author dmitrii.dronov@d2force.com
 * @version 1.0
 * @group factories
 */
public class SelectorFactory {
    final Map<SObjectType, Type> selectorsBySObjectTypes;
    private Map<SObjectType, Selector> mocksBySObjectTypes = new Map<SObjectType, Selector>();

    /**
     * @description Constructor
     * @param selectorsBySObjectTypes - a map of selectors by sObject types
     */
    public SelectorFactory(final Map<SObjectType, Type> selectorsBySObjectTypes) {
        this.selectorsBySObjectTypes = selectorsBySObjectTypes == null ? new Map<SObjectType, Type>() : selectorsBySObjectTypes;
    }

    /**
     * @description Method to create an instance of a selector
     * @param sObjectType - sObject type
     * @return an instance of a selector
     */
    public Selector newInstance(final SObjectType sObjectType) {
        if (sObjectType == null) {
            throw new SelectorFactoryException('SObjectType parameter cannot be null.');
        }

        if (Test.isRunningTest()) {
            if (this.mocksBySObjectTypes.containsKey(sObjectType)) {
                return this.mocksBySObjectTypes.get(sObjectType);
            }
        }

        final Type selectorType = this.selectorsBySObjectTypes.get(sObjectType);
        if (selectorType == null) {
            throw new SelectorFactoryException('No selector found for SObjectType: ' + sObjectType.getDescribe().getName());
        }

        Selector.ISelectorConstructor selectorConstructor = (Selector.ISelectorConstructor) selectorType.newInstance();
        return selectorConstructor.newInstance();
    }

    @testVisible
    private void setMock(final SObjectType sObjectType, final Selector mock) {
        this.mocksBySObjectTypes.put(sObjectType, mock);
    }

    /**
     * @description Selector Factory Exception class
     * @author dmitrii.dronov@d2force.com
     * @version 1.0
     * @group exceptions
     */
    public class SelectorFactoryException extends Exception {
    }
}
