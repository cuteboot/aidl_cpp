package extra;
import import.camera_frame_metadata_t;
import extra.IMemory;


interface ICameraClient {
    void notifyCallback(int msgType, int ext1, int ext2);
    void dataCallback(int msgType, IMemory data,
        out camera_frame_metadata_t * metadata);
    void dataCallbackTimestamp(long timestamp, int msgType, IMemory data);
}
