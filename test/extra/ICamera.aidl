package extra;
import extra.ICameraClient;
import extra.IMemory;
import extra.ISurfaceTexture;


interface ICamera {
    void disconnect();
    void connect(ICameraClient client);
    void lock();
    void unlock();
    void setPreviewDisplay(int surface);
    void setPreviewTexture(ISurfaceTexture surfaceTexture);
    void setPreviewCallbackFlag(int flag);
    void startPreview();
    void stopPreview();
    boolean previewEnabled();
    void startRecording();
    void stopRecording();
    boolean recordingEnabled();
    void releaseRecordingFrame(IMemory mem);
    void autoFocus();
    void cancelAutoFocus();
    void takePicture(int msgType);
    void setParameters(String params);
    String getParameters();
    void sendCommand(int cmd, int arg1, int arg2);
    void storeMetaDataInBuffers(boolean enabled);
}
