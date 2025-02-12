/**
 * @description Application class
 * @author dmitrii.dronov@d2force.com
 * @version 1.0
 */
public without sharing class Application {
    public static SelectorFactory selectors = new SelectorFactory(
        new Map<SObjectType, Type>{
            
        }
    );

    public static ServiceFactory services = new ServiceFactory(
        new Map<Type, Type>{ UserService.class => UserService.class, ContentDistributionService.class => ContentDistributionService.class }
    );

    public static DomainFactory domains = new DomainFactory(
        new Map<SObjectType, Type>{
            
        }
    );

    /**
     * @description Application Exception class
     * @author dmitrii.dronov@d2force.com
     * @version 1.0
     */
    public class ApplicationException extends Exception {
    }
}
