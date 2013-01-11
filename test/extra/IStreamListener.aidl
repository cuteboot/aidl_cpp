package extra;
import import.AMessage;
import import.size_t;

interface IStreamListener {
    void bogus_setListener(); /* only in IStreamSource */
    void bogus_setBuffers(); /* only in IStreamSource */
    void bogus_onBufferAvailable(); /* only in IStreamSource */
    void queueBuffer(in size_t index, in size_t size);
    void issueCommand( int cmd, boolean synchronous, in AMessage msg);
}
