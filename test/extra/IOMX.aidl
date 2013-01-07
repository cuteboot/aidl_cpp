package extra;
import extra.buffer_id;
import extra.GraphicBuffer;
import extra.IMemory;
import extra.IOMXObserver;
import extra.ListComponentInfo;
import extra.node_id;
import extra.omx_message;
import extra.void_ptr;


interface IOMX {
    boolean livesLocally(int node, int pid);
    void listNodes(ListComponentInfo[] list);
    void allocateNode( in String name, IOMXObserver observer, node_id[] node);
    void freeNode(int node);
    void sendCommand( int node, int cmd, int param);
    void getParameter( int node, int index, out void[] params, int size);
    void setParameter( int node, int index, in void[] params, int size);
    void getConfig( int node, int index, out void[] params, int size);
    void setConfig( int node, int index, in void[] params, int size);
    void getState( int node, out int[]  state);
    void enableGraphicBuffers( int node, int port_index, boolean enable);
    void useBuffer( int node, int port_index, IMemory params, in buffer_id[] buffer);
    void useGraphicBuffer( int node, int port_index, GraphicBuffer graphicBuffer, in buffer_id[] buffer);
    void storeMetaDataInBuffers( int node, int port_index, boolean enable);
    void allocateBuffer( int node, int port_index, int size, buffer_id[] buffer, out void_ptr[] buffer_data);
    void allocateBufferWithBackup( int node, int port_index, IMemory params, out buffer_id[] buffer);
    void freeBuffer( int node, int port_index, int buffer);
    void fillBuffer(int node, int buffer);
    void emptyBuffer( int node, int buffer, int range_offset, int range_length, int flags, int timestamp);
    void getExtensionIndex( int node, in String parameter_name, out int[] index);
    void onMessage(in omx_message msg);
    void getGraphicBufferUsage( int node, int port_index, out int[] usage);
}
