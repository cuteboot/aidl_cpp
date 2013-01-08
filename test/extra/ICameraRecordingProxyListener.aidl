package extra;
import extra.IMemory;


interface ICameraRecordingProxyListener {
    void dataCallbackTimestamp(long timestamp, int msgType, IMemory data);
}
