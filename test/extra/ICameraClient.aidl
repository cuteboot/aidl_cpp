package extra;
import extra.camera_frame_metadata_t;
import extra.IMemory;


interface ICameraClient {
    void notifyCallback(int msgType, int ext1, int ext2);
    void dataCallback(int msgType, IMemory data, camera_frame_metadata_t[] metadata);
    void dataCallbackTimestamp(int timestamp, int msgType, IMemory data);
}
