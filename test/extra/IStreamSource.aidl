package extra;
import extra.IMemory;
import extra.IStreamListener;


interface IStreamSource {
    void setListener(in IStreamListener listener);
    void setBuffers(in IMemory * buffers);
    void onBufferAvailable(long index);
}
