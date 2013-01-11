package extra;
import extra.IMountServiceListener;
import extra.IMountShutdownObserver;
import extra.IObbActionListener;


interface IMountService {
    void registerListener(IMountServiceListener listener);
    void unregisterListener(IMountServiceListener listener);
    boolean isUsbMassStorageConnected();
    void setUsbMassStorageEnabled(boolean enable);
    boolean isUsbMassStorageEnabled();
    int mountVolume(in String mountPoint);
    int unmountVolume( String mountPoint, boolean force,
        boolean removeEncryption);
    int formatVolume(in String mountPoint);
    int getStorageUsers(in String mountPoint, out int * users);
    int getVolumeState(in String mountPoint);
    int createSecureContainer(in String id, int sizeMb,
        String fstype, String key, int ownerUid);
    int finalizeSecureContainer(in String id);
    int destroySecureContainer(in String id);
    int mountSecureContainer(in String id, String key, int ownerUid);
    int unmountSecureContainer(in String id, boolean force);
    boolean isSecureContainerMounted(in String id);
    int renameSecureContainer(in String oldId, String newId);
    boolean getSecureContainerPath(in String id, String path);
    int getSecureContainerList(in String id, out String * containers);
    void shutdown(IMountShutdownObserver observer);
    void finishMediaUpdate();
    void mountObb(in String filename, String key,
        IObbActionListener token, int nonce);
    void unmountObb(in String filename, boolean force,
        IObbActionListener token, int nonce);
    boolean isObbMounted(in String filename);
    boolean getMountedObbPath(in String filename, out String * path);
    void isExternalStorageEmulated(); /* not defined */
    int decryptStorage(in String password);
    int encryptStorage(in String password);
}
