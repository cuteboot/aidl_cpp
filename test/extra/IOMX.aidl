package extra;
import import.buffer_id;
import import.GraphicBuffer;
import extra.IMemory;
import extra.IOMXObserver;
import import.ListComponentInfo;
import import.omx_message;
import import.status_t;
import import.CString;
import import.IntPtr;


interface IOMX {
    void connect(); /* not defined */
    boolean livesLocally(in IntPtr node, int pid);
    status_t listNodes(out ListComponentInfo * list);
    status_t allocateNode( in CString name, IOMXObserver observer,
        out IntPtr * node);
    status_t freeNode(in IntPtr node);
    status_t sendCommand(in IntPtr node, int cmd, int param);
    status_t getParameter(in IntPtr node, int index, inout void * params, int size);
    status_t setParameter(in IntPtr node, int index, in void * params, int size);
    status_t getConfig(in IntPtr node, int index, inout void * params, int size);
    status_t setConfig(in IntPtr node, int index, in void * params, int size);
    status_t getState(in IntPtr node, out int *  state);
    status_t enableGraphicBuffers(in IntPtr node, int port_index, boolean enable);
    status_t useBuffer(in IntPtr node, int port_index, IMemory params,
        out buffer_id * buffer);
    status_t useGraphicBuffer(in IntPtr node, int port_index,
        in GraphicBuffer graphicBuffer, out buffer_id * buffer);
    status_t storeMetaDataInBuffers(in IntPtr node, int port_index, boolean enable);
    status_t allocateBuffer(in IntPtr node, int port_index, int size,
        out buffer_id * buffer, out int * buffer_data);
    status_t allocateBufferWithBackup(in IntPtr node, int port_index,
        IMemory params, out buffer_id * buffer);
    status_t freeBuffer(in IntPtr node, int port_index, int buffer);
    status_t fillBuffer(in IntPtr node, int buffer);
    status_t emptyBuffer(in IntPtr node, int buffer, int range_offset,
        int range_length, int flags, long timestamp);
    status_t getExtensionIndex(in IntPtr node, in CString parameter_name,
        out int * index);
    void onMessage_bogus(); /* this is only in the IOMXObserver interface */
    status_t getGraphicBufferUsage(in IntPtr node, int port_index,
        out int * usage);
}
