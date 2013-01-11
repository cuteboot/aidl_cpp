package extra;
import import.GraphicBuffer;
import import.QueueBufferInput;
import import.QueueBufferOutput;
import import.status_t;

interface ISurfaceTexture {
    status_t requestBuffer(int slot, out GraphicBuffer *  buf);
    status_t setBufferCount(int bufferCount);
    status_t dequeueBuffer(out int * buf, int w, int h, int format, int usage);
    status_t queueBuffer(int buf, in QueueBufferInput input,
        out QueueBufferOutput *  output);
    status_t cancelBuffer(int buf);
    int query(int what, out int *  value);
    status_t setSynchronousMode(boolean enabled);
    status_t connect(int api, in QueueBufferOutput *  output);
    status_t disconnect(int api);
}
