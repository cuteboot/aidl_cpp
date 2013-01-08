package extra;

interface IServiceManager {
    IBinder getService( String name);
    IBinder checkService( String name);
    void addService( String name, IBinder service, boolean allowIsolated);
    String * listServices();
}
