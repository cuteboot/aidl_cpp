package extra;
import import.sockaddr_storage;


interface ICommonTimeConfig {
    void getMasterElectionPriority(out int[] priority);
    void setMasterElectionPriority(int priority);
    void getMasterElectionEndpoint(out sockaddr_storage[] addr);
    void setMasterElectionEndpoint(in sockaddr_storage[] addr);
    void getMasterElectionGroupId(out long[] id);
    void setMasterElectionGroupId(long id);
    void getInterfaceBinding(String ifaceName);
    void setInterfaceBinding(in String ifaceName);
    void getMasterAnnounceInterval(out int[] interval);
    void setMasterAnnounceInterval(int interval);
    void getClientSyncInterval(out int[] interval);
    void setClientSyncInterval(int interval);
    void getPanicThreshold(out int[] threshold);
    void setPanicThreshold(int threshold);
    void getAutoDisable(out boolean[] autoDisable);
    void setAutoDisable(boolean autoDisable);
    void forceNetworklessMasterMode();
}
