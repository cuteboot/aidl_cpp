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
import import.status_t;
import import.String8;
import import.CString;
import import.ssize_t;

interface IDrmManagerService {
    int addUniqueId(boolean isNative);
    void removeUniqueId(int uniqueId);
    void addClient(int uniqueId);
    void removeClient(int uniqueId);
    status_t setDrmServiceListener( int uniqueId, IDrmServiceListener infoListener);
    status_t installDrmEngine(int uniqueId, String drmEngineFile);
    DrmConstraints *  getConstraints( int uniqueId, in String8 *  path,
        in int action);
    DrmMetadata *  getMetadata(int uniqueId, in String *  path);
    boolean canHandle(int uniqueId, in String8 path, in String8 mimeType);
    DrmInfoStatus *  processDrmInfo(int uniqueId, in DrmInfo *  drmInfo);
    DrmInfo *  acquireDrmInfo(int uniqueId,
        in DrmInfoRequest *  drmInforequest);
    status_t saveRights(int uniqueId, in DrmRights drmRights,
        in String8 rightsPath, in String8 contentPath);
    String8 getOriginalMimeType(int uniqueId, in String8 path);
    int getDrmObjectType( int uniqueId, in String8 path, in String8 mimeType);
    int checkRightsStatus(int uniqueId, in String8 path, int action);
    status_t consumeRights( int uniqueId, in DecryptHandle *  decryptHandle,
        int action, boolean reserve);
    status_t setPlaybackStatus( int uniqueId, in DecryptHandle *  decryptHandle,
        int playbackStatus, long position);
    boolean validateAction( int uniqueId, in String8 path, int action,
        in ActionDescription description);
    status_t removeRights(int uniqueId, in String8 path);
    status_t removeAllRights(int uniqueId);
    int openConvertSession(int uniqueId, in String8 mimeType);
    DrmConvertedStatus *  convertData( int uniqueId, int convertId,
        in DrmBuffer *  inputData);
    DrmConvertedStatus *  closeConvertSession(int uniqueId, int convertId);
    status_t getAllSupportInfo( int uniqueId, out int * length,
        out DrmSupportInfo *  drmSupportInfoArray);
    DecryptHandle *  openDecryptSession( int uniqueId, int fd,
        long offset, long length, in CString  mime);
    DecryptHandle *  openDecryptSessionFromUri( int uniqueId,
        in CString  uri, in CString  mime);
    status_t closeDecryptSession(int uniqueId, in DecryptHandle *  decryptHandle);
    status_t initializeDecryptUnit(int uniqueId, in DecryptHandle *  decryptHandle,
        int decryptUnitId, in DrmBuffer *  headerInfo);
    status_t decrypt(int uniqueId, in DecryptHandle *  decryptHandle,
        int decryptUnitId, in DrmBuffer *  encBuffer,
        out DrmBuffer *  decBuffer, out DrmBuffer *  IV);
    status_t finalizeDecryptUnit( int uniqueId,
        in DecryptHandle *  decryptHandle, int decryptUnitId);
    int pread(int uniqueId, in DecryptHandle * decryptHandle,
        out void * buffer, in ssize_t numBytes, long offset);
}
