package extra;
import extra.IMemory;
import import.LinearTransform;


interface IAudioTrack {
    IMemory getCblk();
    void start();
    void stop();
    void flush();
    void mute(boolean foo);
    void pause();
    void attachAuxEffect(int effectId);
    void allocateTimedBuffer(int size, out IMemory[]  buffer);
    void queueTimedBuffer(IMemory buffer, long pts);
    void setMediaTimeTransform(in LinearTransform xform, int target);
}
