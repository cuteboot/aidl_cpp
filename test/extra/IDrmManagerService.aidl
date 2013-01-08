package extra;
import import.ActionDescription;
import import.DecryptHandle;
import import.DrmBuffer;
import import.DrmConstraints;
import import.DrmConvertedStatus;
import import.DrmInfo;
import import.DrmInfoStatus;
import import.DrmMetadata;
import import.DrmRights;
import import.DrmSupportInfo;
import import.DrmInfoRequest;
import extra.IDrmServiceListener;


interface IDrmManagerService {
    int addUniqueId(boolean isNative);
    void removeUniqueId(int uniqueId);
    void addClient(int uniqueId);
    void removeClient(int uniqueId);
    void setDrmServiceListener( int uniqueId, IDrmServiceListener infoListener);
    void installDrmEngine(int uniqueId, String drmEngineFile);
    DrmConstraints[]  getConstraints( int uniqueId, in String[]  path,
        in int action);
    DrmMetadata[]  getMetadata(int uniqueId, in String[]  path);
    boolean canHandle(int uniqueId, String path, String mimeType);
    DrmInfoStatus[]  processDrmInfo(int uniqueId, in DrmInfo[]  drmInfo);
    DrmInfo[]  acquireDrmInfo(int uniqueId,
        in DrmInfoRequest[]  drmInforequest);
    void saveRights(int uniqueId, in DrmRights drmRights,
        String rightsPath, String contentPath);
    String getOriginalMimeType(int uniqueId, String path);
    int getDrmObjectType( int uniqueId, String path, String mimeType);
    int checkRightsStatus(int uniqueId, String path, int action);
    void consumeRights( int uniqueId, in DecryptHandle[]  decryptHandle,
        int action, boolean reserve);
    void setPlaybackStatus( int uniqueId, in DecryptHandle[]  decryptHandle,
        int playbackStatus, long position);
    boolean validateAction( int uniqueId, String path, int action,
        in ActionDescription description);
    void removeRights(int uniqueId, String path);
    void removeAllRights(int uniqueId);
    int openConvertSession(int uniqueId, String mimeType);
    DrmConvertedStatus[]  convertData( int uniqueId, int convertId,
        in DrmBuffer[]  inputData);
    DrmConvertedStatus[]  closeConvertSession(int uniqueId, int convertId);
    void getAllSupportInfo( int uniqueId, int  length,
        out DrmSupportInfo *  drmSupportInfoArray);
    DecryptHandle[]  openDecryptSession( int uniqueId, int fd,
        long offset, long length, in String  mime);
    DecryptHandle[]  openDecryptSessionFromUri( int uniqueId,
        in String  uri, in String  mime);
    void closeDecryptSession(int uniqueId, in DecryptHandle[]  decryptHandle);
    void initializeDecryptUnit(int uniqueId, in DecryptHandle[]  decryptHandle,
        int decryptUnitId, in DrmBuffer[]  headerInfo);
    void decrypt(int uniqueId, in DecryptHandle[]  decryptHandle,
        int decryptUnitId, in DrmBuffer[]  encBuffer,
        out DrmBuffer[]  decBuffer, out DrmBuffer[]  IV);
    void finalizeDecryptUnit( int uniqueId,
        in DecryptHandle[]  decryptHandle, int decryptUnitId);
    int pread(int uniqueId, in DecryptHandle[] decryptHandle,
        out void[] buffer, int numBytes, long offset);
}
