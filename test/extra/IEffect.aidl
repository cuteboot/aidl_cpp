package extra;
import extra.IMemory;
import import.status_t;


interface IEffect {
    status_t enable();
    status_t disable();
    status_t command(int cmdCode, int cmdSize, in void * pCmdData,
        inout int * pReplySize, out void * pReplyData);
    void disconnect();
    IMemory getCblk();
}
