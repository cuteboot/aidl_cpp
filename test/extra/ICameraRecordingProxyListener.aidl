package extra;
import extra.IMemory;


interface ICameraRecordingProxyListener {
    void dataCallbackTimestamp(int timestamp, int msgType, IMemory data);
}
