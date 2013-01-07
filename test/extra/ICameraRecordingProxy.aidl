package extra;
import extra.ICameraRecordingProxyListener;
import extra.IMemory;


interface ICameraRecordingProxy {
    void startRecording(ICameraRecordingProxyListener listener);
    void stopRecording();
    void releaseRecordingFrame(IMemory mem);
}
