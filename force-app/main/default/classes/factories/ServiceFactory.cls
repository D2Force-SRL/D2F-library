/**
 * @description Class to create an instance of a service
 * @author dmitrii.dronov@d2force.com
 * @version 1.0
 * @group factories
 */
public without sharing class ServiceFactory {
    private final Map<Type, Type> servicesByTypes;
    private Map<Type, Object> mocksByTypes = new Map<Type, Object>();
    /**
     * @description Constructor
     * @param servicesByTypes - a map of services by types
     */
    public ServiceFactory(final Map<Type, Type> servicesByTypes) {
        this.servicesByTypes = servicesByTypes == null ? new Map<Type, Type>() : servicesByTypes;
    }

    /**
     * @description Method to create an instance of a service
     * @param serviceType - service type
     * @return an instance of a service
     */
    public Object newInstance(final Type serviceType) {
        if (serviceType == null) {
            throw new ServiceFactoryException('ServiceType parameter cannot be null.');
        }

        if (Test.isRunningTest()) {
            if (this.mocksByTypes.containsKey(serviceType)) {
                return this.mocksByTypes.get(serviceType);
            }
        }

        final Type serviceImplementationType = this.servicesByTypes.get(serviceType);
        if (serviceImplementationType == null) {
            throw new ServiceFactoryException('No service found for ServiceType: ' + serviceType.getName());
        }

        return serviceImplementationType.newInstance();
    }

    @TestVisible
    private void setMock(final Type serviceType, final Object mock) {
        this.mocksByTypes.put(serviceType, mock);
    }

    /**
     * @description Exception class
     * @author dmitrii.dronov@d2force.com
     * @version 1.0
     * @group exceptions
     */
    public class ServiceFactoryException extends Exception {
    }
}
