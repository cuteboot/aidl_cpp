package extra;
import import.AMessage;

interface IStreamListener {
    void queueBuffer(long index, long size);
    void issueCommand( int cmd, boolean synchronous, in AMessage msg);
}
