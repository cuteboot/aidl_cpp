package extra;
import extra.IMemory;
import extra.IStreamListener;
import import.size_t;

interface IStreamSource {
    void setListener(in IStreamListener listener);
    void setBuffers(in IMemory * buffers);
    void onBufferAvailable(in size_t index);
    void bogus_queueBuffer(); /* only in IStreamListener */
    void bogus_issueCommand(); /* only in IStreamListener */
}
