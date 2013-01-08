package extra;
import extra.ICameraRecordingProxyListener;
import extra.IMemory;
import import.status_t;


interface ICameraRecordingProxy {
    status_t startRecording(ICameraRecordingProxyListener listener);
    void stopRecording();
    void releaseRecordingFrame(IMemory mem);
}
