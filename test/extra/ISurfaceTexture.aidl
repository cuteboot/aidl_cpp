package extra;
import import.GraphicBuffer;
import import.QueueBufferInput;
import import.QueueBufferOutput;


interface ISurfaceTexture {
    void requestBuffer(int slot, out GraphicBuffer *  buf);
    void setBufferCount(int bufferCount);
    void dequeueBuffer(in int * slot, int w, int h, int format, int usage);
    void queueBuffer(int slot, in QueueBufferInput input,
        in QueueBufferOutput *  output);
    void cancelBuffer(int slot);
    int query(int what, in int *  value);
    void setSynchronousMode(boolean enabled);
    void connect(int api, in QueueBufferOutput *  output);
    void disconnect(int api);
}
