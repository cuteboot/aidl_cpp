package extra;
import import.sockaddr_storage;
import import.status_t;


interface ICommonTimeConfig {
    status_t getMasterElectionPriority(out int * priority);
    status_t setMasterElectionPriority(int priority);
    status_t getMasterElectionEndpoint(out sockaddr_storage * addr);
    status_t setMasterElectionEndpoint(in sockaddr_storage * addr);
    status_t getMasterElectionGroupId(out long * id);
    status_t setMasterElectionGroupId(long id);
    status_t getInterfaceBinding(String ifaceName);
    status_t setInterfaceBinding(in String ifaceName);
    status_t getMasterAnnounceInterval(out int * interval);
    status_t setMasterAnnounceInterval(int interval);
    status_t getClientSyncInterval(out int * interval);
    status_t setClientSyncInterval(int interval);
    status_t getPanicThreshold(out int * threshold);
    status_t setPanicThreshold(int threshold);
    status_t getAutoDisable(out boolean * autoDisable);
    status_t setAutoDisable(boolean autoDisable);
    status_t forceNetworklessMasterMode();
}
