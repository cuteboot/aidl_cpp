package extra;
import extra.IMemory;
import import.LinearTransform;
import import.status_t;


interface IAudioTrack {
    IMemory getCblk();
    status_t start();
    void stop();
    void flush();
    void mute(boolean e);
    void pause();
    status_t attachAuxEffect(int effectId);
    status_t allocateTimedBuffer(int size, out IMemory * buffer);
    status_t queueTimedBuffer(IMemory buffer, long pts);
    status_t setMediaTimeTransform(in LinearTransform xform, int target);
}
