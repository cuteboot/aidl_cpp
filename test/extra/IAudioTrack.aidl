package extra;
import extra.IMemory;
import extra.LinearTransform;


interface IAudioTrack {
    IMemory getCblk();
    void start();
    void stop();
    void flush();
    void mute(boolean foo);
    void pause();
    void attachAuxEffect(int effectId);
    void allocateTimedBuffer(int size, IMemory[]  buffer);
    void queueTimedBuffer(IMemory buffer, long pts);
    void setMediaTimeTransform(LinearTransform xform, int target);
}
