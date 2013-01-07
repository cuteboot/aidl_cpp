package extra;

interface IStreamListener {
    void queueBuffer(long index, long size);
    void issueCommand( Command cmd, boolean synchronous, in AMessage msg);
}
