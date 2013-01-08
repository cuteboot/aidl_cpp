package extra;
import extra.ICameraClient;
import extra.IMemory;
import extra.ISurfaceTexture;
import import.status_t;
import import.String8;
import import.CString;
import import.Surface;


interface ICamera {
    void disconnect();
    status_t setPreviewDisplay(in Surface surface);
    status_t setPreviewTexture(ISurfaceTexture surfaceTexture);
    void setPreviewCallbackFlag(int flag);
    status_t startPreview();
    status_t stopPreview();
    status_t autoFocus();
    status_t cancelAutoFocus();
    status_t takePicture(int msgType);
    status_t setParameters(in String8 params);
    String8 getParameters();
    status_t sendCommand(int cmd, int arg1, int arg2);
    status_t connect(ICameraClient client);
    status_t lock();
    status_t unlock();
    boolean previewEnabled();
    status_t startRecording();
    void stopRecording();
    boolean recordingEnabled();
    void releaseRecordingFrame(IMemory mem);
    status_t storeMetaDataInBuffers(boolean enabled);
}
